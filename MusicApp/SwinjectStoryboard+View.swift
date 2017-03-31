//
//  SwinjectStoryboard+View.swift
//  YoutubeMVVM
//
//  Created by Tran Tuat on 3/6/17.
//  Copyright © 2017 TranTuat. All rights reserved.
//

import Foundation
import MVVMAdditions
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
        let container = defaultContainer
        container.register(Navigator.self) { _ in
            NavigatorImpl()
            }.inObjectScope(.container)
        
        container.register(MainViewModel.self) { (container)  in
            MainViewModel(navigator: container.resolve(Navigator.self))
        }.inObjectScope(.transient)
        
        container.storyboardInitCompleted(MainViewController.self) { (container, controller) in
            controller.viewModel = container.resolve(MainViewModel.self)
        }
//
//        container.register(DetailSettingViewModel.self) { (container)  in
//            DetailSettingViewModel(navigator: container.resolve(Navigator.self))
//            }.inObjectScope(.transient)
//        
//        container.storyboardInitCompleted(DetailSettingViewController.self) { (container, controller) in
//            controller.viewModel = container.resolve(DetailSettingViewModel.self)
//        }
//

    }
    
}
