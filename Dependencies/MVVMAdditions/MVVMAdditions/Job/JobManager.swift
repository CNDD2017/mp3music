//
//  JobManager.swift
//  View
//
//  Created by Giáp Trần on 12/6/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import Foundation

public class JobManager: OperationQueue {

    // MARK: Constructor
    
    public init(name: String, maxConcurrentOperationCount: Int) {
        super.init()
        
        self.name = name
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
}
