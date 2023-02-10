//
//  WeeksHabitTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

// in progress deve ser o atual!! ou seja, o dia atual
// toBeCompleted tem que ser o atual inprogress
enum HabitProgressState: Int {
    case notChosenByUser = 0
    case failed = 1
    case inProgress = 2
    case completed = 3
    case toBeCompleted = 4
}

class WeeksHabitTableViewCell: UITableViewCell {
    
    private let weekDays: [String] = ["SEG", "TER", "QUA", "QUI", "SEX", "SÁB", "DOM"]
    private var chosenDays: [Int] = []
    private var unchosenDays: [String] = []
    
    @IBOutlet weak var weeksHabitTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier: String = String(describing: WeeksHabitTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView()
        selectionStyle = .none
        backgroundColor = .viewBackgroundColor
        
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.register(WeekDaysCollectionViewCell.nib(), forCellWithReuseIdentifier: WeekDaysCollectionViewCell.identifier)
    }
    
    /// isso faz com que segunda seja o primeiro dia da semana (1) e não domingo
    private func setFirstDayOfTheWeek(_ calendar: Calendar, _ currentWeekdayInt: inout Int) {
        if calendar.firstWeekday == 2 {
            currentWeekdayInt -= 1
            if currentWeekdayInt == 0 {
                currentWeekdayInt = 7
            }
        }
    }
    
    func setupCell(model: DuringWeekHabitsModel) {
        weeksHabitTitleLabel.text = model.title
        let notChosenDaysByUser = weekDays.filter({ !model.daysOfTheWeek.keys.contains($0) })
        self.unchosenDays = notChosenDaysByUser
        
        // semana atual em int (mais especificamente o dia atual)
        let today = Date()
        var calendar = Calendar.current
        var currentWeekdayInt = calendar.component(.weekday, from: today)
        
        setFirstDayOfTheWeek(calendar, &currentWeekdayInt)
        
        // weekDays = base pra ser comparada
        for day in weekDays {
            // dias escolhidos
            if model.daysOfTheWeek.keys.contains(day) {
                if let dayChosenByUserToInt = DaysOfTheWeek.convertDayToInt(rawValue: day) {
                    print("currentWeekdayInt=========", currentWeekdayInt)
                    // failed: diferente de hoje e não foi concluído
                    if dayChosenByUserToInt < currentWeekdayInt && !model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.failed.rawValue)
                        // in progress: está no prazo e ainda não foi concluido
                    } else if dayChosenByUserToInt == currentWeekdayInt && !model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.inProgress.rawValue)
                        // completed: está no prazo e foi concluido
                    } else if dayChosenByUserToInt <= currentWeekdayInt && model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.completed.rawValue)
                    } else {
                        chosenDays.append(HabitProgressState.toBeCompleted.rawValue)
                    }
                }
            } else {
                // dias não escolhidos pelo usuario
                chosenDays.append(HabitProgressState.notChosenByUser.rawValue)
            }
        }
    }
}

extension WeeksHabitTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDaysCollectionViewCell.identifier, for: indexPath) as? WeekDaysCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(day: weekDays[indexPath.row], isActive: chosenDays[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
