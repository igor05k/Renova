//
//  ProgressViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 27/01/23.
//

import UIKit

class ProgressViewController: BaseViewController {
    
    var screen: ProgressView?
    
    override func loadView() {
        screen = ProgressView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
