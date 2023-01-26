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
    
    var habit: HabitData?
    private var viewmodel: NewGoalViewModel = NewGoalViewModel()
    
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
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(NewGoalDetailsTableViewCell.nib(), forCellReuseIdentifier: NewGoalDetailsTableViewCell.identifier)
        tableView.register(FrequencyTableViewCell.nib(), forCellReuseIdentifier: FrequencyTableViewCell.identifier)
        tableView.register(ReminderTableViewCell.nib(), forCellReuseIdentifier: ReminderTableViewCell.identifier)
        tableView.register(SaveGoalTableViewCell.nib(), forCellReuseIdentifier: SaveGoalTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        habit = HabitData()
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewGoalDetailsTableViewCell.identifier, for: indexPath) as? NewGoalDetailsTableViewCell else { return UITableViewCell() }
            
            cell.didChangeTitle = { [weak self] title in
                self?.habit?.title = title
            }
            
            cell.didChangeDescription = { [weak self] description in
                self?.habit?.description = description
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FrequencyTableViewCell.identifier, for: indexPath) as? FrequencyTableViewCell else { return UITableViewCell() }
            
            cell.daysSelected = { [weak self] days in
                self?.habit?.daysSelected = days
            }
            
            cell.deadlineSelected = { [weak self] days in
                self?.habit?.deadline = days
            }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath) as? ReminderTableViewCell else { return UITableViewCell() }
            
            cell.notificationAlarmChanged = { [weak self] time in
                self?.habit?.time = time
            }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveGoalTableViewCell.identifier, for: indexPath) as? SaveGoalTableViewCell else { return SaveGoalTableViewCell() }
            
                cell.didTapCreateHabit = { [weak self] in
                    self?.viewmodel.validadeFields(title: self?.habit?.title ?? "Nenhum título",
                                                   description: self?.habit?.description ?? "Nenhuma descrição",
                                                   days: self?.habit?.daysSelected ?? [:],
                                                   deadline: self?.habit?.deadline ?? 0,
                                                   time: self?.habit?.time ?? "No timer")
                }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 4 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 130
        case 2:
            return 110
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
            headerView.backgroundColor = .clear
            return headerView
        }
        return nil
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
