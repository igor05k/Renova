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
    private func setFirstDayOfTheWeek(_ calendar: Calendar, _ currentWeekdayInt: inout Int) -> Int {
        if calendar.firstWeekday == 2 {
            currentWeekdayInt -= 1
            if currentWeekdayInt == 0 {
                currentWeekdayInt = 7
            }
        }
        return currentWeekdayInt
    }
    
    func setupCell(model: DuringWeekHabitsModel) {
        weeksHabitTitleLabel.text = model.title
        
        // semana atual em int (mais especificamente o dia atual)
        let today = Date()
        let calendar = Calendar.current
        
        var weekdayInt = calendar.component(.weekday, from: today)
        let currentWeekdayInt = setFirstDayOfTheWeek(calendar, &weekdayInt)
        
        let currentDayOfTheWeek = "08/02/2023" // quarta-feira
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        /*
         se um dos dias selecionados pelo usuario for menor que esse esse cara (startDate),
         significa que o dia do habito extrapola a semana e seu status deve ser toBeCompleted
         (exemplo: hoje quarta feira, criei um habito que inclui segunda e terça, logo,
         segunda e terça tem que começar com toBeCompleted e não failed.
         */
         
        guard let startDateFormatted = dateFormatter.date(from: currentDayOfTheWeek) else {
            print("string couldnt be converted to a date")
            return
        }
        
        // start date precisa ser convetido para que segunda seja 1 e domingo 7
        var startDate = Calendar.current.component(.weekday, from: startDateFormatted)
        let currentStartDate = setFirstDayOfTheWeek(calendar, &startDate)
        
        // weekDays = base pra ser comparada
        for day in weekDays {
            // dias escolhidos
            if model.daysOfTheWeek.keys.contains(day) {
                if let dayChosenByUserToInt = DaysOfTheWeek.convertDayToInt(rawValue: day) {
                    if dayChosenByUserToInt < currentStartDate {
                        chosenDays.append(HabitProgressState.toBeCompleted.rawValue)
                    } else {
                        // failed: passou de hoje e não foi concluído
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
