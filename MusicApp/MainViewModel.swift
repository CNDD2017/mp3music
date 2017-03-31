//
//  MainViewModel.swift
//  MusicApp
//
//  Created by Tran Tuat on 3/10/17.
//  Copyright © 2017 TranTuat. All rights reserved.
//

import Foundation
import MVVMAdditions
import RxCocoa
import RxSwift

class MainViewModel: ViewModel {
    
    var musics = Variable<[Music]>([])
    
    override init(navigator: Navigator?) {
        super.init(navigator: navigator)
    }
    
}
