//
//  RegisterView.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class RegisterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .viewBackgroundColor
//        setupVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVisualElements() {
        setupNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupPasswordConfirmationLabel()
        setupPasswordConfirmationTextField()
    }
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Nome"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var emailLabel: UILabel = {
        let email = UILabel()
        email.text = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    lazy var nameTextField: UITextField = {
        let nametf = UITextField()
        nametf.translatesAutoresizingMaskIntoConstraints = false
        nametf.layer.borderWidth = 1
        nametf.layer.cornerRadius = 5
        nametf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return nametf
    }()
    
    lazy var emailTextField: UITextField = {
        let emailtf = UITextField()
        emailtf.translatesAutoresizingMaskIntoConstraints = false
        emailtf.layer.borderWidth = 1
        emailtf.layer.cornerRadius = 5
        emailtf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return emailtf
    }()
    
    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.text = "Senha"
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordtf = UITextField()
        passwordtf.translatesAutoresizingMaskIntoConstraints = false
        passwordtf.layer.borderWidth = 1
        passwordtf.layer.cornerRadius = 5
        passwordtf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return passwordtf
    }()
    
    lazy var passwordConfirmationLabel: UILabel = {
        let passwordConfirmationLbl = UILabel()
        passwordConfirmationLbl.text = "Confirme sua senha"
        passwordConfirmationLbl.translatesAutoresizingMaskIntoConstraints = false
        return passwordConfirmationLbl
    }()
    
    lazy var passwordConfirmationTextField: UITextField = {
        let passwordConfirmationTf = UITextField()
        passwordConfirmationTf.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmationTf.layer.borderWidth = 1
        passwordConfirmationTf.layer.cornerRadius = 5
        passwordConfirmationTf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return passwordConfirmationTf
    }()
    
    
    // MARK: Name
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNameTextField() {
        addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    // MARK: Email
    private func setupEmailLabel() {
        addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            emailLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
        ])
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    // MARK: Password
    private func setupPasswordLabel() {
        addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
        ])
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupPasswordConfirmationLabel() {
        addSubview(passwordConfirmationLabel)
        
        NSLayoutConstraint.activate([
            passwordConfirmationLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            passwordConfirmationLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordConfirmationLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
    
    private func setupPasswordConfirmationTextField() {
        addSubview(passwordConfirmationTextField)
        
        NSLayoutConstraint.activate([
            passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordConfirmationLabel.bottomAnchor, constant: 15),
            passwordConfirmationTextField.leadingAnchor.constraint(equalTo: passwordConfirmationLabel.leadingAnchor),
            passwordConfirmationTextField.trailingAnchor.constraint(equalTo: passwordConfirmationLabel.trailingAnchor),
            passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
