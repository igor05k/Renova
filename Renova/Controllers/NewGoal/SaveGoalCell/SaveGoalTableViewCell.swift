//
//  SaveGoalTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import UIKit

class SaveGoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var saveButtonElement: UIButton!
    
    var didTapCreateHabit: (() -> Void)?
    
    static let identifier: String = String(describing: SaveGoalTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configButton()
        clipsToBounds = true
    }
    
    private func configButton() {
        saveButtonElement.setTitle("Criar hábito", for: .normal)
        saveButtonElement.layer.cornerRadius = 10
        saveButtonElement.clipsToBounds = true
        saveButtonElement.setTitleColor(.white, for: .normal)
        saveButtonElement.backgroundColor = .backgroundPrimary
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        didTapCreateHabit?()
    }
}
