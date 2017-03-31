//
//  ViewModel.swift
//  Core
//
//  Created by Giáp Trần on 8/17/16.
//  Copyright © 2016 TVG Soft, Inc. All rights reserved.
//

import EventBusSwift

public protocol ViewModelDelegate {
    
    func onDidLoad()
    
    func onDidReceive(data: Any?)
    
    func onWillAppear()
    
    func onWillDisappear()
 
    func onReceiveMemoryWarning()
    
    func onDestroy()
    
}

open class ViewModel: NSObject {
    
    // MARK: Property
    
    public private(set) weak var navigator: Navigator?
    
    // MARK: Constructor
    
    public init(navigator: Navigator?) {
        self.navigator = navigator
    }
    
    deinit {
        #if DEBUG
            print("\(String(describing: self)) deinit.")
        #endif
    }
    
    // MARK: Public method
    
    public func dismissView(animated flag: Bool, completion: (() -> Swift.Void)?) {
        navigator?.dismissView(animated: flag, completion: completion)
    }
    
    public func popView(animated flag: Bool) {
        navigator?.popView(animated: flag)
    }
    
    public func register(name aName: Notification.Name, handler: @escaping EventBusHandler) {
        EventBus.shared.register(self, name: aName, handler: handler)
    }
    
    public func unregister(name aName: Notification.Name) {
        EventBus.shared.unregister(self, name: aName)
    }
    
    public func post(name aName: Notification.Name, object: Any?) {
        EventBus.shared.post(name: aName, object: object)
    }
    
    public func postSticky(name aName: Notification.Name, object: Any?) {
        EventBus.shared.postSticky(name: aName, object: object)
    }
    
}

extension ViewModel: ViewModelDelegate {
    
    open func onDidLoad() {
        
    }
    
    open func onDidReceive(data: Any?) {
        
    }
    
    open func onWillAppear() {
        
    }
    
    open func onWillDisappear() {
        
    }
    
    open func onReceiveMemoryWarning() {
        
    }
    
    open func onDestroy() {
        
    }
    
}
