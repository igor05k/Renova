//
//  TodaysHabitEmptyStateTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 03/02/23.
//

import UIKit

class TodaysHabitEmptyStateTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: TodaysHabitEmptyStateTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var emptyStateImage: UIImageView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var addNewHabitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
        selectionStyle = .none
        backgroundColor = .viewBackgroundColor
    }
    
    private func configCell() {
        emptyStateImage.image = UIImage(named: "habit-emptystate")
        emptyStateLabel.text = "Parece que você ainda não tem nenhum hábito pra hoje criado."
        emptyStateLabel.numberOfLines = 0
        
        addNewHabitButton.setTitle("Criar novo hábito", for: .normal)
        addNewHabitButton.layer.cornerRadius = 10
        addNewHabitButton.clipsToBounds = true
        addNewHabitButton.setTitleColor(.white, for: .normal)
        addNewHabitButton.backgroundColor = .backgroundPrimary
    }
}
