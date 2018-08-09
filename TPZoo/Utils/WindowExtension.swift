//
//  WindowExtension.swift
//  TPZoo
//
//  Created by HSI on 2018/8/9.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import UIKit
extension UIWindow {
    
    public var visibleViewController : UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(rootViewController)
    }
    
    
    public static func getVisibleViewControllerFrom(_ vc:UIViewController?) -> UIViewController? {
        
        if let nc = vc as? UINavigationController{
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}
