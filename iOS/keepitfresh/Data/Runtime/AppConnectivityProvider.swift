//
//  AppConnectivityProvider.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Provides app-wide connectivity state using Swift concurrency and AsyncStream broadcasts.
//

import Foundation
@preconcurrency import Network

enum NetworkConnectivityStatus: String, Sendable, Equatable {
    case connected
    case disconnected
    case requiresConnection
}

enum NetworkConnectionInterface: String, Sendable, Equatable, Hashable, CaseIterable {
    case wifi
    case cellular
    case wiredEthernet
    case loopback
    case other
}

struct NetworkConnectivityState: Sendable, Equatable {
    let status: NetworkConnectivityStatus
    let interfaces: Set<NetworkConnectionInterface>
    let isExpensive: Bool
    let changedAt: Date

    var isOnline: Bool {
        status == .connected
    }

    static let initial = NetworkConnectivityState(
        status: .requiresConnection,
        interfaces: [],
        isExpensive: false,
        changedAt: .distantPast
    )
}

protocol NetworkConnectivityProviding: Sendable {
    func currentState() async -> NetworkConnectivityState
    func isOnline() async -> Bool
    func observeConnectivity() async -> AsyncStream<NetworkConnectivityState>
}

actor AppConnectivityProvider: NetworkConnectivityProviding {
    static let shared = AppConnectivityProvider()

    private var monitorTask: Task<Void, Never>?
    private var currentConnectivityState: NetworkConnectivityState
    private var observers: [UUID: AsyncStream<NetworkConnectivityState>.Continuation]

    init() {
        monitorTask = nil
        currentConnectivityState = .initial
        observers = [:]
    }

    deinit {
        monitorTask?.cancel()
        for observer in observers.values {
            observer.finish()
        }
    }

    func isOnline() async -> Bool {
        startMonitoringIfNeeded()
        return currentConnectivityState.isOnline
    }

    func currentState() async -> NetworkConnectivityState {
        startMonitoringIfNeeded()
        return currentConnectivityState
    }

    func observeConnectivity() async -> AsyncStream<NetworkConnectivityState> {
        startMonitoringIfNeeded()
        return AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
            let id = UUID()
            observers[id] = continuation
            continuation.yield(currentConnectivityState)
            continuation.onTermination = { [weak self] _ in
                Task {
                    await self?.removeObserver(id)
                }
            }
        }
    }
}

private extension AppConnectivityProvider {
    func startMonitoringIfNeeded() {
        guard monitorTask == nil else { return }

        let updates = Self.connectivityUpdates()
        monitorTask = Task { [weak self] in
            for await update in updates {
                guard let self else { return }
                await self.applyConnectivityUpdate(update)
            }
        }
    }

    func applyConnectivityUpdate(_ update: NetworkConnectivityState) {
        guard update != currentConnectivityState else { return }
        currentConnectivityState = update
        for observer in observers.values {
            observer.yield(update)
        }
    }

    func removeObserver(_ id: UUID) {
        observers[id] = nil
    }
}

private extension AppConnectivityProvider {
    static func connectivityUpdates() -> AsyncStream<NetworkConnectivityState> {
        AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
            let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "keepitfresh.connectivity.monitor")
            monitor.start(queue: queue)
            continuation.yield(Self.makeConnectivityState(from: monitor.currentPath))
            let monitoringTask = Task {
                for await path in monitor {
                    continuation.yield(Self.makeConnectivityState(from: path))
                }
                continuation.finish()
            }

            continuation.onTermination = { _ in
                monitoringTask.cancel()
                monitor.cancel()
            }
        }
    }

    static func makeConnectivityState(from path: NWPath) -> NetworkConnectivityState {
        let status: NetworkConnectivityStatus
        switch path.status {
        case .satisfied:
            status = .connected
        case .unsatisfied:
            status = .disconnected
        case .requiresConnection:
            status = .requiresConnection
        @unknown default:
            status = .requiresConnection
        }

        var interfaces = Set<NetworkConnectionInterface>()
        if path.usesInterfaceType(.wifi) {
            interfaces.insert(.wifi)
        }
        if path.usesInterfaceType(.cellular) {
            interfaces.insert(.cellular)
        }
        if path.usesInterfaceType(.wiredEthernet) {
            interfaces.insert(.wiredEthernet)
        }
        if path.usesInterfaceType(.loopback) {
            interfaces.insert(.loopback)
        }
        if path.usesInterfaceType(.other) {
            interfaces.insert(.other)
        }

        return NetworkConnectivityState(
            status: status,
            interfaces: interfaces,
            isExpensive: path.isExpensive,
            changedAt: .now
        )
    }
}
