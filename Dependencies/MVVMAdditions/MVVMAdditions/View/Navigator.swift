//
//  INavigator.swift
//  Core
//
//  Created by Giáp Trần on 8/17/16.
//  Copyright © 2016 TVG Soft, Inc. All rights reserved.
//

import UIKit

public struct ViewKey {
    
    public let name: String
    
    public init(_ rawValue: String) {
        name = rawValue
    }
    
}

public protocol Navigator: class {
    
    func dismissView(animated flag: Bool, completion: (() -> Void)?)
    
    func popView(animated flag: Bool)
    
    func popViewToRoot(animated flag: Bool)
    
    func showView(key akey: ViewKey)
    
    func showView(key akey: ViewKey, data: Any?)
    
    func showAlert(
            title           : String,
            message         : String,
            negativeTitle   : String,
            negativeHandler : ((UIAlertAction) -> Void)?)
    
    func showAlert(
            title           : String,
            message         : String,
            negativeTitle   : String,
            positiveTitle   : String,
            negativeHandler : ((UIAlertAction) -> Void)?,
            positiveHandler : ((UIAlertAction) -> Void)?)
    
    func beginIgnoringEvent()
    
    func endIgnoringEvent()
    
}

extension UIApplication {
    
    public static var currentController: UIViewController? {
        var parentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let viewController = parentViewController?.presentedViewController {
            parentViewController = viewController
        }
        if let tabBarController = parentViewController as? UITabBarController {
            parentViewController = tabBarController.selectedViewController
        }
        if let nagvigationController = parentViewController as? UINavigationController {
            parentViewController = nagvigationController.topViewController
        }
        if let viewController = parentViewController?.childViewControllers.last {
            return viewController
        }
        return parentViewController
    }
    
}
