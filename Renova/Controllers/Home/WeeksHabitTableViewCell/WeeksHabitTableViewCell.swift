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
    
    // para fazer o dequeue das células corretamente e apresentar os dias de acordo
    private let weekDays: [String] = ["SEG", "TER", "QUA", "QUI", "SEX", "SÁB", "DOM"]
    
    // para poder usar como base e fazer a iteração com os dias escolhidos pelo usuário
    private let weekDaysDateComponents: [DateComponents] = [DateComponents(weekday: 1),
                                               DateComponents(weekday: 2),
                                               DateComponents(weekday: 3),
                                               DateComponents(weekday: 4),
                                               DateComponents(weekday: 5),
                                               DateComponents(weekday: 6),
                                               DateComponents(weekday: 7)]
    
    // para mostrar os backgrounds de acordo com o status do hábito
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
    
    func setupCell(model: DuringWeekHabitsModel) {
        // data atual do usuário
        let today = Date()
        
        let secondsInADay: TimeInterval = 24 * 60 * 60 // 24 hours * 60 minutes * 60 seconds

        let twoDaysFromNow = today.addingTimeInterval(2 * secondsInADay)
        
        // Define um DateFormatter para formatar as datas como string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        
        for day in weekDaysDateComponents {
            if model.daysOfTheWeek.contains(day) {
                if let dateChosenByUser = calendar.nextDate(after: today, matching: day, matchingPolicy: .nextTime) {
                    
                    let dayChosenByUser = calendar.component(.day, from: dateChosenByUser)
                    let todayDate = calendar.component(.day, from: twoDaysFromNow)

                    /// working
                    if dayChosenByUser == todayDate && !model.markAsCompleted.contains(day) {
                        // DATA ATUAL; HABITO NÃO CONCLUIDO
                        chosenDays.append(HabitProgressState.inProgress.rawValue)
                    } else if dayChosenByUser < todayDate && !model.markAsCompleted.contains(day) {
                        // DATA PASSOU; HABITO NÃO CONCLUIDO
                        chosenDays.append(HabitProgressState.failed.rawValue)
                    } else if dayChosenByUser <= todayDate && model.markAsCompleted.contains(day) {
                        // DATA AINDA NÃO PASSOU; HABITO FOI CONCLUIDO
                        chosenDays.append(HabitProgressState.completed.rawValue)
                    } else {
                        // TO BE COMPLETED
                        chosenDays.append(HabitProgressState.toBeCompleted.rawValue)
                    }
                }
            } else {
                chosenDays.append(HabitProgressState.notChosenByUser.rawValue)
            }
        }
        
        // basicamente isso faz com que o primeiro elemento da array seja segunda-feira e o último seja domingo
        let firstElement = chosenDays.removeFirst()
        chosenDays.append(firstElement)
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
