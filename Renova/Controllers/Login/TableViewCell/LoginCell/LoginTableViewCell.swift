//
//  LoginTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    var didTapLoginButton: ((_ email: String, _ password: String) -> Void)?
    var didTapRegisterButton: (() -> Void)?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    static let identifier: String = String(describing: LoginTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with viewmodel: LoginViewModel) {
        viewmodel.delegate = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .viewBackgroundColor
        configCell()
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        didTapRegisterButton?()
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            didTapLoginButton?(email, password)
        }
    }
    
    func configCell() {
        emailLabel.text = "Email"
        emailTextField.placeholder = "Digite seu email..."
        
        passwordLabel.text = "Senha"
        passwordTextField.placeholder = "Digite sua senha..."
        
        signInButton.setTitle("Entrar", for: .normal)
        signUpButton.setTitle("Registrar", for: .normal)
    }
}

extension LoginTableViewCell: LoadingDelegate {
    func manageLoading(didChangeLoadingState isLoading: Bool) {
        if isLoading {
            signInButton.configuration?.showsActivityIndicator = true
            signInButton.configuration?.title = nil
            signInButton.isEnabled = false
        } else {
            signInButton.configuration?.showsActivityIndicator = false
            signInButton.configuration?.title = "Entrar"
            signInButton.isEnabled = true
        }
    }
}
