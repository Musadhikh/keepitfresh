//
//  UIApplication+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import UIKit

extension UIApplication {
    var activeKeyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }?
            .windows
            .first { $0.isKeyWindow }
    }
}
