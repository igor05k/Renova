//
//  NewGoalViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//
    
import UIKit

class NewGoalViewController: UIViewController {
    // goal name
    // description (optional)
    // frequency
    // notifications switch on off
    // deadline (optional)
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var screen: NewGoalView?
    
    override func loadView() {
        screen = NewGoalView()
        view = screen
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(NewGoalDetailsTableViewCell.nib(), forCellReuseIdentifier: NewGoalDetailsTableViewCell.identifier)
        tableView.register(FrequencyTableViewCell.nib(), forCellReuseIdentifier: FrequencyTableViewCell.identifier)
        tableView.register(ReminderTableViewCell.nib(), forCellReuseIdentifier: ReminderTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        ])
    }
}

extension NewGoalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewGoalDetailsTableViewCell.identifier, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FrequencyTableViewCell.identifier, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 130
        default:
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Detalhes"
        case 1:
            return "Frequência"
        case 2:
            return "Lembretes"
        default:
            return nil
        }
    }
}
