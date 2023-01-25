//
//  RegisterTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    var didTapCreateAccount: ((_ name: String, _ email: String, _ password: String, _ passwordConfirmation: String) -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationLabel: UILabel!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    static let identifier: String = String(describing: RegisterTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with viewModel: RegisterViewModel) {
        viewModel.delegate = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .viewBackgroundColor
        configCell()
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        if let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let passwordConfirm = passwordConfirmationTextField.text {
            didTapCreateAccount?(name, email, password, passwordConfirm)
        }
    }
    
    func setupButton(isLoading: Bool, title: String?, isEnabled: Bool) {
        signUpButton.configuration?.showsActivityIndicator = isLoading
        signUpButton.configuration?.title = title
        signUpButton.isEnabled = isEnabled
    }
    
    func configCell() {
        nameLabel.text = "Nome"
        nameTextField.placeholder  = "Digite seu nome..."
        
        emailLabel.text = "Email"
        emailTextField.placeholder = "Digite seu email..."
        
        passwordLabel.text = "Senha"
        passwordTextField.placeholder = "Digite sua senha..."
        
        passwordConfirmationLabel.text = "Confirmação de senha"
        passwordConfirmationTextField.placeholder = "Confirme sua senha..."
        
        signUpButton.setTitle("Criar conta", for: .normal)
    }
}

extension RegisterTableViewCell: LoadingDelegate {
    func manageLoading(didChangeLoadingState isLoading: Bool) {
        if isLoading {
            signUpButton.configuration?.showsActivityIndicator = true
            signUpButton.configuration?.title = nil
            signUpButton.isEnabled = false
        } else {
            signUpButton.configuration?.showsActivityIndicator = false
            signUpButton.configuration?.title = "Criar conta"
            signUpButton.isEnabled = true
        }
    }
}
