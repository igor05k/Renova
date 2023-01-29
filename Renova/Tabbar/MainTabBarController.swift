//
//  MainTabBarController.swift
//  Renova
//
//  Created by Igor Fernandes on 24/01/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let home = UINavigationController(rootViewController: HomeViewController())
    let progress = UINavigationController(rootViewController: ProgressViewController())
    let settings = UINavigationController(rootViewController: SettingsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        configControllers()
        configItems()
        tabBar.backgroundColor = .backgroundSecondary
        tabBar.tintColor = .iconColor
        tabBar.barTintColor = .iconColor
    }
    
    func configControllers() {
        setViewControllers([home, progress, settings], animated: true)
    }
    
    func configItems() {
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.tabBarItem.title = "Home"
        
        progress.tabBarItem.image = UIImage(systemName: "chart.bar.fill")
        progress.tabBarItem.title = "Progresso"
        
        settings.tabBarItem.image = UIImage(systemName: "gear")
        settings.tabBarItem.title = "Configurações"
        
        tabBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
