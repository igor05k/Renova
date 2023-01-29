//
//  SettingsViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 27/01/23.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    var screen: SettingsView?
    
    override func loadView() {
        screen = SettingsView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
