//
//  WeeksHabitTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

class WeeksHabitTableViewCell: UITableViewCell {
    
    private let weekDays: [String] = ["S", "T", "Q", "Q", "S", "S", "D"]
    private var activeHabitDays: [Int] = []
    
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
    
    // adicionar para receber uma array de dias.. comparar com weekDays array e os dias q forem iguais destacar, os outros deixar opaco ou algo do tipo, significando que naqueles dias o habito nao devera ser cumprido
    func setupCell(model: DuringWeekHabitsModel) {
        weeksHabitTitleLabel.text = model.title
        let arrayOfNumbers = weekDays.map { regularItems -> Int in
            if model.daysOfTheWeek.contains(regularItems) {
                return 1
            } else {
                return 0
            }
        }
        self.activeHabitDays = arrayOfNumbers
        print(arrayOfNumbers)
    }
}

extension WeeksHabitTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDaysCollectionViewCell.identifier, for: indexPath) as? WeekDaysCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(day: weekDays[indexPath.row], isActive: activeHabitDays[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
