//
//  TodaysHabitCollectionViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

class TodaysHabitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var habitTitle: UILabel!
    @IBOutlet weak var habitDescription: UILabel!
    @IBOutlet weak var habitImageView: UIImageView!
    @IBOutlet weak var habitCheckmarkContainer: UIView!
    
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    static let identifier: String = String(describing: TodaysHabitCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        
        layer.cornerRadius = 10
    }
    
    func setupCell() {
        habitTitle.text = "Correr 5km"
        
        habitDescription.numberOfLines = 2
        habitDescription.text = "Correr e treinar todos os dias 5km"
        
        habitImageView.image = UIImage(named: "running")
        
        habitCheckmarkContainer.layer.cornerRadius = 15
        habitCheckmarkContainer.clipsToBounds = true
        habitCheckmarkContainer.layer.borderWidth = 1
        habitCheckmarkContainer.layer.borderColor = UIColor.systemBlue.cgColor
        
        checkmarkImageView.image = UIImage(systemName: "checkmark")
    }

}
