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
    case failed = 0
    case inProgress = 1
    case notChosenByUser = 2
    case completed = 3
    
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
    
    /// converte as três primeiras letras dos dias da semana em int
    func convertToWeekdayInt(_ weekday: String) -> Int {
        let weekdays = ["SEG": 1, "TER": 2, "QUA": 3, "QUI": 4, "SEX": 5, "SÁB": 6, "DOM": 7]
        let firstThree = String(weekday.prefix(3))
        return weekdays[firstThree] ?? 0
    }
    
    // deadline = dias escolhidos pelo usuario = model.daysOfTheWeek
    func setupCell(model: DuringWeekHabitsModel) {
        weeksHabitTitleLabel.text = model.title
        let notChosenDaysByUser = weekDays.filter({ !model.daysOfTheWeek.contains($0) })
        self.unchosenDays = notChosenDaysByUser
        
        // semana atual em int (mais especificamente o dia atual)
        let today = Date()
        let calendar = Calendar.current
        let currentWeekdayInt = calendar.component(.weekday, from: today)
        
        // weekDays = base pra ser comparada
        for day in weekDays {
            // dias escolhidos
            if model.daysOfTheWeek.contains(day) {
                if let dayChosenByUserToInt = DaysOfTheWeek.convertDayToInt(rawValue: day) {
                    // failed: diferente de hoje e não foi concluído
                    if dayChosenByUserToInt != currentWeekdayInt && !model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.failed.rawValue)
                        // in progress: está no prazo e ainda não foi concluido
                    } else if dayChosenByUserToInt >= currentWeekdayInt && !model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.inProgress.rawValue)
                        // to be completed: está no prazo e foi concluido
                    } else if dayChosenByUserToInt >= currentWeekdayInt && model.markAsCompleted.contains(day) {
                        chosenDays.append(HabitProgressState.completed.rawValue)
                    }
                }
            } else {
                // dias não escolhidos pelo usuario
                chosenDays.append(HabitProgressState.notChosenByUser.rawValue)
            }
        }
        
        print(chosenDays)
        
//        let daysInNumbers = weekDays.map { weekDay -> Int in
//            if model.daysOfTheWeek.contains(weekDay) {
//                return HabitProgressState.inProgress.rawValue
//            } else if unchosenDays.contains(weekDay) {
//                return HabitProgressState.notChosenByUser.rawValue
//            } else {
//                return 2
//            }
//        }
        
//        self.chosenDays = daysInNumbers
//        print(chosenDays)
        
        //    checkWeekDaysState(model)
        //    print(chosenDays)
    }
}

extension WeeksHabitTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDaysCollectionViewCell.identifier, for: indexPath) as? WeekDaysCollectionViewCell else { return UICollectionViewCell() }
        // cell.setupCell(day: weekDays[indexPath.row], isActive: activeHabitDays[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}



// adicionar para receber uma array de dias.. comparar com weekDays array e os dias q forem iguais destacar, os outros deixar opaco ou algo do tipo, significando que naqueles dias o habito nao devera ser cumprido
//    private func checkWeekDaysState(_ model: DuringWeekHabitsModel) {
//        // pega a array com todos os dias da semana e filtra com os items que está faltando no model
//        // resumidamente: dias que o usuário NÃO escolheu
//        let notChosenDaysByUser = weekDays.filter({ !model.daysOfTheWeek.contains($0) })
//
//        // semana atual em int (mais especificamente o dia atual)
//        let today = Date()
//        let calendar = Calendar.current
//        let currentDay = calendar.component(.weekday, from: today)
//
//        for day in model.daysOfTheWeek {
//            let dayChosenByUser = convertToWeekdayInt(day)
//            // tambem verificar se o isCompleted flag no firebase ou outro lugar está true
//            if dayChosenByUser < currentDay {
//                chosenDays.append(HabitProgressState.incomplete.rawValue)
//                return HabitProgressState.incomplete.rawValue
//            } else {
//                chosenDays.append(HabitProgressState.inProgress.rawValue)
//                return HabitProgressState.inProgress.rawValue
//            }
//        }
//        return nil
//    }
