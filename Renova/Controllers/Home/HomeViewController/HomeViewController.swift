//
//  HomeViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

enum HomeSections: Int {
    case averageProgress = 0
    case todaysHabit = 1
    case weeksHabit = 2
}

class HomeViewController: BaseViewController {
    
    var screen: HomeView?
    
    private var viewmodel: HomeViewModel = HomeViewModel()
    
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
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(ProgressCardTableViewCell.nib(), forCellReuseIdentifier: ProgressCardTableViewCell.identifier)
        tableView.register(TodaysHabitTableViewCell.nib(), forCellReuseIdentifier: TodaysHabitTableViewCell.identifier)
        tableView.register(TodaysHabitEmptyStateTableViewCell.nib(), forCellReuseIdentifier: TodaysHabitEmptyStateTableViewCell.identifier)
        tableView.register(WeeksHabitTableViewCell.nib(), forCellReuseIdentifier: WeeksHabitTableViewCell.identifier)
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
        
        controller.onSuccessfulSaveHabit = { [weak self] habit in
            let todaysHabit = TodaysHabitModel(title: habit.title, description: habit.description, image: habit.habitImage)
            self?.viewmodel.setTodaysHabit(data: todaysHabit)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
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
        switch indexPath.section {
        case HomeSections.averageProgress.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProgressCardTableViewCell.identifier, for: indexPath)
            return cell
        case HomeSections.todaysHabit.rawValue:
            if viewmodel.todaysHabit.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodaysHabitEmptyStateTableViewCell.identifier, for: indexPath) as? TodaysHabitEmptyStateTableViewCell else { return UITableViewCell() }
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodaysHabitTableViewCell.identifier, for: indexPath) as? TodaysHabitTableViewCell else { return UITableViewCell() }
            
            cell.configure(model: viewmodel.todaysHabit)
            return cell
        case HomeSections.weeksHabit.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeeksHabitTableViewCell.identifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case HomeSections.todaysHabit.rawValue:
            if viewmodel.todaysHabit.isEmpty {
                return 1
            }
            return viewmodel.todaysHabit.count
        case HomeSections.weeksHabit.rawValue:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case HomeSections.averageProgress.rawValue:
            return 150
        case HomeSections.todaysHabit.rawValue:
            // empty state
            if viewmodel.todaysHabit.isEmpty {
                return 250
            } else if viewmodel.todaysHabit.count <= 2 {
                return 170
            }
            return 300
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case HomeSections.todaysHabit.rawValue:
            return "Pra hoje"
        case HomeSections.weeksHabit.rawValue:
            return "Durante a semana"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        header.textLabel?.frame = header.bounds
    }
}
