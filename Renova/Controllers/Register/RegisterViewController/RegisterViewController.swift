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
    
    override func loadView() {
        screen = RegisterView()
        view = screen
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        viewModel.configForms()
    }
    
    func configTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RegisterTableViewCell.nib(), forCellReuseIdentifier: RegisterTableViewCell.identifier)
        tableView.register(SignUpTableViewCell.nib(), forCellReuseIdentifier: SignUpTableViewCell.identifier)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier, for: indexPath) as? RegisterTableViewCell else { return UITableViewCell() }
            cell.setup(form: viewModel.dequeueForm(at: indexPath.row))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.identifier, for: indexPath) as? SignUpTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}
