//
//  PageInfo.swift
//  View
//
//  Created by Giáp Trần on 12/8/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import Foundation

public class PageInfo: NSObject {

    // MARK: Property
    
    public static let limit: Int = 20
    
    public var page: Int = -1
    
    public var isFulled: Bool = false
    public var isLoading: Bool = false
    
    public var isCanLoadMore: Bool {
        return !isLoading && !isFulled
    }
    
    public var nextPage: Int {
        page += 1
        return page
    }
    
    // MARK: Public method
    
    public func reset() {
        page = -1
        isFulled = false
        isLoading = false
    }
    
}
