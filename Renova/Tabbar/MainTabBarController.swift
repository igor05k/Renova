//
//  MainTabBarController.swift
//  Renova
//
//  Created by Igor Fernandes on 24/01/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let home = UINavigationController(rootViewController: HomeViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        abc()
    }
    
    func abc() {
        setViewControllers([home], animated: true)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationItem.hidesBackButton = true
//    }
}
