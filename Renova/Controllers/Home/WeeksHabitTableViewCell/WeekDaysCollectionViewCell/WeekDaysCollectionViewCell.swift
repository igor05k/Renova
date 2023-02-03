//
//  WeekDaysCollectionViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

class WeekDaysCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: WeekDaysCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
        backgroundColor = .viewBackgroundColor
    }
    
    private func configCell() {
        checkmarkImageView.isHidden = true
        weekDayLabel.textAlignment = .center
        stackView.layer.cornerRadius = 25
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupCell(day: String, isActive: Int) {
        weekDayLabel.text = day
        if isActive == 0 {
            stackView.layer.borderColor = CGColor(red: 20 / 255, green: 255 / 255, blue: 20 / 255, alpha: 1)
        } else {
            stackView.layer.borderColor = CGColor(red: 20 / 255, green: 20 / 255, blue: 255 / 255, alpha: 1)
        }
    }
}
