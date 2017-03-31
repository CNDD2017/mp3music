//
//  KeychainSwift+Model.swift
//  View
//
//  Created by Giáp Trần on 12/7/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import KeychainSwift

extension KeychainSwift {

    private static let jwtKey = "JWT"
    
    public static var jwt: String? {
        get {
            let keychain = KeychainSwift()
            return keychain.get(KeychainSwift.jwtKey)
        }
        set {
            let keychain = KeychainSwift()
            if let hasValue = newValue {
                keychain.set(hasValue, forKey: KeychainSwift.jwtKey)
            } else {
                keychain.delete(KeychainSwift.jwtKey)
            }
        }
    }
    
}
