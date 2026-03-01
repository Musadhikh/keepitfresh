//
//
//  Button+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Button+Extension <#brief summary#>
//
    

import SwiftUI

extension Button where Label == SwiftUI.Label<Text, Image> {
    init(_ titleKey: LocalizedStringKey, icon: Theme.Icon, action: @escaping @MainActor () -> Void) {
        self.init(titleKey, systemImage: icon.systemName, action: action)
    }
}
