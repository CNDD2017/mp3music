//
//  UITableViewCell+Extension.swift
//  YoutubeMVVM
//
//  Created by Tran Tuat on 3/6/17.
//  Copyright © 2017 TranTuat. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    public static var nib: UINib {
        return UINib(nibName: className, bundle: Bundle.main)
    }
    
    public static var className: String {
        return String(describing: self)
    }
    
}
