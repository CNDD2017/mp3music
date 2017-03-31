//
//  ApiResponse.swift
//  View
//
//  Created by Giáp Trần on 12/7/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import SwiftyJSON

public class ApiResponse<T>: NSObject {

    // MARK: Property
    
    public var error: Error?
    public var data: T?
    
    // MARK: Constructor
    
    public init(json: JSON?, error: Error?) {
        self.error = error
    }
    
}
