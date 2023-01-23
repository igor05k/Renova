//
//  LoginView.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class LoginView: UIView {
    var goToRegister: (() -> Void)?
    
    // MARK: Create elements
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Nome"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var nameTextField: UITextField = {
        let nametf = UITextField()
        nametf.translatesAutoresizingMaskIntoConstraints = false
        nametf.layer.borderWidth = 1
        nametf.layer.cornerRadius = 5
        nametf.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return nametf
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
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.setTitle("Sign In", for: .normal)
        signIn.setTitleColor(.black, for: .normal)
        signIn.translatesAutoresizingMaskIntoConstraints = false
        return signIn
    }()
    
    lazy var signUpButton: UIButton = {
        let register = UIButton()
        register.setTitle("Sign Up", for: .normal)
        register.setTitleColor(.systemBlue, for: .normal)
        register.translatesAutoresizingMaskIntoConstraints = false
        return register
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualElements()
        backgroundColor = .viewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupVisualElements() {
        setupNameLabel()
        setupNameTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setSignInButton()
        setSignUpButton()
    }
    
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
    
    private func setupPasswordLabel() {
        addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            passwordLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
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
    
    private func setSignInButton() {
        addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            signInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
    
    private func setSignUpButton() {
        addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
    
    @objc func didTapSignUp() {
        goToRegister?()
    }
}
