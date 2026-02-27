//
//  View+NetworkConnectivity.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Provides environment-based connectivity injection and a lifecycle-aware SwiftUI modifier for network state observation.
//

import SwiftUI

private struct NetworkConnectivityProviderKey: EnvironmentKey {
    static let defaultValue: any NetworkConnectivityProviding = AppConnectivityProvider.shared
}

extension EnvironmentValues {
    var networkConnectivityProvider: any NetworkConnectivityProviding {
        get { self[NetworkConnectivityProviderKey.self] }
        set { self[NetworkConnectivityProviderKey.self] = newValue }
    }
}

private struct OnNetworkConnectivityChangeModifier: ViewModifier {
    @Environment(\.networkConnectivityProvider) private var connectivityProvider
    let initial: Bool
    let isEnabled: Bool
    let action: @Sendable (NetworkConnectivityState) -> Void

    func body(content: Content) -> some View {
        content
            .task(id: isEnabled) {
                guard isEnabled else { return }

                var hasReceivedInitialState = false
                let updates = await connectivityProvider.observeConnectivity()
                for await state in updates {
                    guard Task.isCancelled == false else { break }

                    if initial == false, hasReceivedInitialState == false {
                        hasReceivedInitialState = true
                        continue
                    }

                    hasReceivedInitialState = true
                    await MainActor.run {
                        action(state)
                    }
                }
            }
    }
}

extension View {
    func networkConnectivityProvider(_ provider: any NetworkConnectivityProviding) -> some View {
        environment(\.networkConnectivityProvider, provider)
    }

    func onNetworkConnectivityChange(
        initial: Bool = true,
        isEnabled: Bool = true,
        perform action: @escaping @Sendable (NetworkConnectivityState) -> Void
    ) -> some View {
        modifier(
            OnNetworkConnectivityChangeModifier(
                initial: initial,
                isEnabled: isEnabled,
                action: action
            )
        )
    }
}
