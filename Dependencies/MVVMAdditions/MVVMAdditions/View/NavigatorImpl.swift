//
//  Navigator.swift
//  Core
//
//  Created by Giáp Trần on 8/17/16.
//  Copyright © 2016 TVG Soft, Inc. All rights reserved.
//

public class NavigatorImpl: Navigator {
    
    // MARK: Constructor
    
    public init() {
        
    }
    
    // MARK: Navigator implement
    
    public func dismissView(animated flag: Bool, completion: (() -> Swift.Void)?) {
        let viewController = UIApplication.currentController
        viewController?.dismiss(animated: flag, completion: completion)
    }
    
    public func popView(animated flag: Bool){
        let viewController = UIApplication.currentController
        _ = viewController?.navigationController?.popViewController(animated: flag)
    }
    
    public func popViewToRoot(animated flag: Bool) {
        let viewController = UIApplication.currentController
        _ = viewController?.navigationController?.popToRootViewController(animated: flag)
    }
    
    public func showView(key akey: ViewKey) {
        showView(key: akey, data: nil)
    }
    
    public func showView(key akey: ViewKey, data: Any?) {
        if let viewController = UIApplication.currentController {
            viewController.performSegue(withIdentifier: akey.name, sender: data)
        }
    }
    
    public func showAlert(
            title           : String,
            message         : String,
            negativeTitle   : String,
            negativeHandler : ((UIAlertAction) -> Void)?) {
        
        if let viewController = UIApplication.currentController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: negativeTitle, style: .cancel, handler: negativeHandler))
            viewController.showDetailViewController(alertController, sender: nil)
        }
    }
    
    public func showAlert(
            title           : String,
            message         : String,
            negativeTitle   : String,
            positiveTitle   : String,
            negativeHandler : ((UIAlertAction) -> Void)?,
            positiveHandler : ((UIAlertAction) -> Void)?) {
        
        if let viewController = UIApplication.currentController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: negativeTitle, style: .cancel, handler: negativeHandler))
            alertController.addAction(UIAlertAction(title: positiveTitle, style: .default, handler: positiveHandler))
            viewController.showDetailViewController(alertController, sender: nil)
        }
    }
    
    public func beginIgnoringEvent() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    public func endIgnoringEvent() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
