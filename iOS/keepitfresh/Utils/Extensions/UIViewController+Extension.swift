//
//  UIViewController.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import UIKit

extension UIViewController {
    var topMost: UIViewController {
        if let presented = presentedViewController { return presented.topMost }
        if let nav = self as? UINavigationController { return nav.visibleViewController?.topMost ?? nav }
        if let tab = self as? UITabBarController { return tab.selectedViewController?.topMost ?? tab }
        return self
    }
    
    static func topViewController() -> UIViewController? {
        UIApplication.shared.activeKeyWindow?.rootViewController?.topMost
    }
}
