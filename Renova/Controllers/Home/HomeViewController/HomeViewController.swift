//
//  HomeViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var screen: HomeView?
    
    override func loadView() {
        screen = HomeView()
        view = screen
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = currentDate()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        addButton.tintColor = .backgroundPrimary
        navigationItem.rightBarButtonItem = addButton
        configTableView()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .backgroundPrimary
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    // MARK: Config tableview
    func configTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(ProgressCardTableViewCell.nib(), forCellReuseIdentifier: ProgressCardTableViewCell.identifier)
    }
    
    func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMM"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    @objc func didTapPlusButton() {
        let controller = NewGoalViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgressCardTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
