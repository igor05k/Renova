//
//  HomeViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var screen: HomeView?
    
    override func loadView() {
        screen = HomeView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
