//
//  LoginViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var screen: LoginView?
    
    override func loadView() {
        screen = LoginView()
        view = screen
        
        setupBindings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupBindings() {
        screen?.goToRegister = {
            let registerViewController = RegisterViewController()
            self.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
}

