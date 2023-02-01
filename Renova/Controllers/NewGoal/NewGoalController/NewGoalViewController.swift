//
//  NewGoalViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//
    
import UIKit

enum NewGoalSections: Int {
    case details = 0
    case frequency = 1
    case reminder = 2
    case habitImages = 3
    case saveButton = 4
}

class NewGoalViewController: BaseViewController {
    
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
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = true
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(NewGoalDetailsTableViewCell.nib(), forCellReuseIdentifier: NewGoalDetailsTableViewCell.identifier)
        tableView.register(FrequencyTableViewCell.nib(), forCellReuseIdentifier: FrequencyTableViewCell.identifier)
        tableView.register(ReminderTableViewCell.nib(), forCellReuseIdentifier: ReminderTableViewCell.identifier)
        tableView.register(ChooseImageTableViewCell.nib(), forCellReuseIdentifier: ChooseImageTableViewCell.identifier)
        tableView.register(SaveGoalTableViewCell.nib(), forCellReuseIdentifier: SaveGoalTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        habit = HabitData()
        setTableViewConstraints()
        setupBindings()
        title = "Novo hábito"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .viewBackgroundColor
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .viewBackgroundColor
        tabBarItem.standardAppearance = tabBarAppearance
        tabBarItem.scrollEdgeAppearance = tabBarItem.standardAppearance
    }
    
    
    func setupBindings() {
        viewmodel.onEmptyFrequency = {
            Alert.showDefaultAlert(title: "Atenção", message: CreateAGoalErrors.emptyFrequency.localizedDescription, vc: self)
        }
        
        viewmodel.onEmptyTitle = {
            Alert.showDefaultAlert(title: "Atenção", message: CreateAGoalErrors.emptyTitle.localizedDescription, vc: self)
        }
        
        viewmodel.onEmptyHabitImage = {
            Alert.showDefaultAlert(title: "Atenção", message: CreateAGoalErrors.emptyHabitImage.localizedDescription, vc: self)
        }
    }
    
    func setTableViewConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension NewGoalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case NewGoalSections.details.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewGoalDetailsTableViewCell.identifier, for: indexPath) as? NewGoalDetailsTableViewCell else { return UITableViewCell() }
            
            cell.didChangeTitle = { [weak self] title in
                self?.habit?.title = title
            }
            
            cell.didChangeDescription = { [weak self] description in
                self?.habit?.description = description
            }
            
            cell.backgroundColor = .backgroundCell
            
            return cell
        case NewGoalSections.frequency.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FrequencyTableViewCell.identifier, for: indexPath) as? FrequencyTableViewCell else { return UITableViewCell() }
            
            cell.daysSelected = { [weak self] days in
                self?.habit?.daysSelected = days
            }
            
            cell.deadlineSelected = { [weak self] days in
                self?.habit?.deadline = days
            }
            
            cell.backgroundColor = .backgroundCell
            
            return cell
        case NewGoalSections.reminder.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath) as? ReminderTableViewCell else { return UITableViewCell() }
            
            cell.notificationAlarmChanged = { [weak self] time in
                self?.habit?.time = time
            }
            
            cell.backgroundColor = .backgroundCell
            
            return cell
        case NewGoalSections.habitImages.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseImageTableViewCell.identifier, for: indexPath) as? ChooseImageTableViewCell else { return UITableViewCell() }
            
            cell.imageChosenByUser = { [weak self] habitImage in
                self?.habit?.habitImage = habitImage
            }
           
            return cell
        case NewGoalSections.saveButton.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveGoalTableViewCell.identifier, for: indexPath) as? SaveGoalTableViewCell else { return SaveGoalTableViewCell() }
            
                cell.didTapCreateHabit = { [weak self] in
                    self?.viewmodel.validadeFields(title: self?.habit?.title ?? "Nenhum título",
                                                   description: self?.habit?.description ?? "Nenhuma descrição",
                                                   days: self?.habit?.daysSelected ?? [:],
                                                   deadline: self?.habit?.deadline ?? 0,
                                                   time: self?.habit?.time ?? "Nenhum timer",
                                                   habitImage: self?.habit?.habitImage ?? "Nenhuma imagem")
                }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 5 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case NewGoalSections.details.rawValue:
            return 160
        case NewGoalSections.frequency.rawValue:
            return 130
        case NewGoalSections.reminder.rawValue:
            return 110
        case NewGoalSections.habitImages.rawValue:
            return 100
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == NewGoalSections.saveButton.rawValue {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
            headerView.backgroundColor = .clear
            return headerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case NewGoalSections.details.rawValue:
            return "Detalhes"
        case NewGoalSections.frequency.rawValue:
            return "Frequência"
        case NewGoalSections.reminder.rawValue:
            return "Lembretes"
        case NewGoalSections.habitImages.rawValue:
            return "Aparência"
        default:
            return nil
        }
    }
}
