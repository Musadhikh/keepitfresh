//
//  VersionCheckProvider.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation

struct VersionCheckProvider: VersionCheckProviding {
    
    func requiresVersionUpdate(metadata: AppMetadata) -> Bool {
        let required = metadata.minimumVersion.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let current = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            // If we cannot determine current version, force update to be safe.
            return true
        }
        return compare(currentVersion: current, minimumVersion: required) == .orderedAscending
    }
    
    // MARK: - Semantic version comparison (numeric dot-separated)
    // Treats "1.2" == "1.2.0". Non-numeric components are ignored beyond leading digits.
    private func compare(currentVersion: String, minimumVersion: String) -> ComparisonResult {
        let lhs = normalize(version: currentVersion)
        let rhs = normalize(version: minimumVersion)
        
        let maxCount = max(lhs.count, rhs.count)
        for i in 0..<maxCount {
            let l = i < lhs.count ? lhs[i] : 0
            let r = i < rhs.count ? rhs[i] : 0
            if l < r { return .orderedAscending }
            if l > r { return .orderedDescending }
        }
        return .orderedSame
    }
    
    private func normalize(version: String) -> [Int] {
        version
            .split(separator: ".")
            .map { component -> Int in
                // Extract leading digits to handle cases like "1b", "2-rc1"
                let digits = component.prefix { $0.isNumber }
                return Int(digits) ?? 0
            }
            // Trim trailing zeros for fair comparison (e.g., 1.2 == 1.2.0)
            .trimmedTrailingZeros()
    }
}

private extension Array where Element == Int {
    func trimmedTrailingZeros() -> [Int] {
        var copy = self
        while copy.last == 0 { _ = copy.popLast() }
        return copy
    }
}
