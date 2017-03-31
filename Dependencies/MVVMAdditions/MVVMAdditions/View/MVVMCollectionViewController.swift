//
//  CollectionViewController.swift
//  ViewModel
//
//  Created by Giáp Trần on 12/1/16.
//  Copyright © 2016 Giáp Trần. All rights reserved.
//

import UIKit
import RxSwift

open class MVVMCollectionViewController: UICollectionViewController {
    
    // MARK: Property
    
    public var disposeBag: DisposeBag?
    
    open var delegate: ViewModelDelegate? {
        fatalError("Must implement delegate getter.")
    }
    
    // MARK: Override method
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = destination(of: segue) as? UIViewController {
            controller.assignData(sender)
        }
    }
    
    public override func assignData(_ data: Any?) {
        delegate?.onDidReceive(data: data)
    }
    
    // MARK: Public method
    
    open func onDestroy() {
        delegate?.onDestroy()
        disposeBag = nil
    }
    
    // MARK: Descontructor
    
    deinit {
        #if DEBUG
            print("\(String(describing: self)) deinit.")
        #endif
    }
    
}

extension MVVMCollectionViewController {
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.onDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        delegate?.onWillAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.onWillDisappear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isBeingDismissed {
            onDestroy()
        }
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        delegate?.onReceiveMemoryWarning()
    }
    
    open override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        guard let _ = parent else {
            onDestroy()
            
            return
        }
    }
    
}

// MARK: TableViewController orientation

extension MVVMCollectionViewController {
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    open override var isBeingDismissed: Bool {
        return navigationController?.isBeingDismissed ?? super.isBeingDismissed
    }
    
}
