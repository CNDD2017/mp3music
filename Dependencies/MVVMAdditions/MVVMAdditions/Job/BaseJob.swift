//
//  BaseJob.swift
//  View
//
//  Created by Giáp Trần on 12/6/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import Foundation

open class BaseJob: Operation {

    // MARK: Property
    
    private var _isFinished: Bool = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _isExecuting: Bool = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    open override var isFinished: Bool {
        return _isFinished
    }
    
    open override var isExecuting: Bool {
        return _isExecuting
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    // MARK: Public method
    
    open override func start() {
        if isCancelled {
            return
        }
        _isExecuting = true
        
        run()
    }
    
    open func run() {
        
    }
    
    open func stop() {
        _isExecuting = false
        _isFinished = true
    }
    
}
