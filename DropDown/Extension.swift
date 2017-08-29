//
//  Extension.swift
//  DropDown
//
//  Created by arabian9ts on 2017/08/29.
//
//  http://qiita.com/The_Shimon/items/80dbf50bc85c527f10f3 writen by The_Shimon

import Foundation
import UIKit

extension UIApplication {
    // return frontmost vc
    static func frontmost(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return frontmost(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return frontmost(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return frontmost(controller: presented)
        }
        return controller
    }
}
