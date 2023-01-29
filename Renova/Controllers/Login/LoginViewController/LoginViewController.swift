//
//  LoginViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private var screen: LoginView?
    private var viewModel: LoginViewModel = LoginViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func loadView() {
        screen = LoginView()
        view = screen
        tableViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // adjust nav bar background color and remove 1px hairline border
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupBindings() {
        viewModel.onPasswordWrong = { [weak self] error in
            self?.showErrorMessage(error)
        }
        
        viewModel.onSignInWithGoogleSuccesful = { [weak self] in
            let controller = MainTabBarController()
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showErrorMessage(_ errorMessage: Error) {
        Alert.showDefaultAlert(title: "Atenção", message: errorMessage.localizedDescription, vc: self)
    }
    
    func tableViewConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LoginTableViewCell.nib(), forCellReuseIdentifier: LoginTableViewCell.identifier)
    }
    
    func goToRegister() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func goToHome() {
        let controller = MainTabBarController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func didTapLogin(_ email: String, _ password: String) {
        viewModel.signIn(email, password) { [weak self] result in
            switch result {
            case .success(_):
                self?.goToHome()
            case .failure(let error):
                self?.showErrorMessage(error)
            }
        }
    }
    
    private func didTapSignInWithGoogle() {
        viewModel.signInWithGoogle(present: self)
    }
}

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoginTableViewCell.identifier, for: indexPath) as? LoginTableViewCell else { return UITableViewCell() }
        cell.didTapRegisterButton = { [weak self] in
            self?.goToRegister()
        }
        
        cell.didTapLoginButton = { [weak self] email, password in
            self?.didTapLogin(email, password)
        }
        
        cell.didTapSignInWithGoogle = { [weak self] in
            self?.didTapSignInWithGoogle()
        }
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { tableView.frame.size.height }
}
