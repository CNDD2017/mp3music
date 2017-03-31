//
//  ViewController.swift
//  MusicApp
//
//  Created by Tran Tuat on 3/10/17.
//  Copyright © 2017 TranTuat. All rights reserved.
//

import UIKit
import MVVMAdditions

class MainViewController: MVVMViewController {
    
    var viewModel: MainViewModel!
    var progress: CircularProgress?
    
    @IBOutlet weak var p: CircularProgress!
    
    override var delegate: ViewModelDelegate?{
        return viewModel
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UIView(frame: CGRect(origin: CGPoint.zero,
                                        size: CGSize(width: 300, height: 300)))
         progress = CircularProgress(frame: CGRect(origin: CGPoint.zero,
                                                              size: CGSize(width: 80, height: 80)))
        progress?.center = CGPoint(x: v.bounds.width * 0.5, y: v.bounds.height * 0.5)

        v.addSubview(progress!)
  //      XCPlaygroundPage.currentPage.liveView = view

        progress?.startAnimating(duration: 5.0)
        
        view.addSubview(v)
        
    }

    @IBAction func startAnimation(_ sender: Any) {
               progress?.startAnimating(duration: 3.0)
    }
    @IBAction func stopAnimation(_ sender: Any) {
        progress?.stopAnimating()

    }
    @IBAction func start(_ sender: Any) {
        p.startAnimating(duration: 3.0)
    }
    @IBAction func stop(_ sender: Any) {
        p.stopAnimating()
    }
    
 
}

