//
//  Image+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Adds a convenience initializer to create SF Symbol images from Theme.Icon.
//

import SwiftUI

extension Image {
    init(icon: Theme.Icon) {
        self.init(systemName: icon.systemName)
    }
}

