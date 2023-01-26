//
//  DaysOfTheWeekCollectionViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//

import UIKit

class DaysOfTheWeekCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayButton: UIButton!
    
    var isActive: Bool = true
    
    var didChangeDays: ((_ cell: UICollectionViewCell) -> Void)?
    
    static let identifier: String = String(describing: DaysOfTheWeekCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        dayButton.layer.cornerRadius = 10
    }
    
    func setupLabels(daysOfTheWeek: String) {
        dayLabel.text = daysOfTheWeek
    }
    
    
    @IBAction func daysToggled(_ sender: UIButton) {
        isActive = !isActive
        didChangeDays?(self)
        changeDaysBackgrounds(isActive: isActive)
    }
    
    private func changeDaysBackgrounds(isActive: Bool) {
        if isActive {
            dayButton.backgroundColor = .backgroundPrimary
        } else {
            dayButton.backgroundColor = .clear
            dayButton.layer.borderWidth = 1
            dayButton.layer.borderColor = CGColor(red: 37 / 255, green: 46 / 255, blue: 66 / 255, alpha: 1)
        }
    }
}
