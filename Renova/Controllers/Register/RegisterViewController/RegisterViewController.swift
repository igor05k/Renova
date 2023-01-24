//
//  RegisterViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class RegisterViewController: UIViewController {
    private var screen: RegisterView?
    private var viewModel: RegisterViewModel = RegisterViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        tableViewConstraints()
        setupBindings()
    }
    
    override func loadView() {
        screen = RegisterView()
        view = screen
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
    
    func setupBindings() {
        viewModel.onRegistrationFailed = { error in
            Alert.showDefaultAlert(title: "Atenção", message: error.localizedDescription, vc: self)
        }
        
        viewModel.emailAlreadyInUse = { error in
            Alert.showDefaultAlert(title: "Atenção", message: "Esse email já está sendo utilizado", vc: self)
        }
        
        viewModel.unexpectedError = { error in
            Alert.showDefaultAlert(title: "Atenção", message: "Algo deu errado enquanto sua conta era criada", vc: self)
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RegisterTableViewCell.nib(), forCellReuseIdentifier: RegisterTableViewCell.identifier)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as? RegisterTableViewCell else { return UITableViewCell() }
        cell.didTapCreateAccount = { [weak self] name, email, password, passwordConfirm in
            self?.viewModel.createAccount(name, email, password, passwordConfirm) { [weak self] success in
                if success {
//                    let controller = MainTabBarController()
//                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { tableView.frame.size.height }   
}
