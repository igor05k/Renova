//
//  NewGoalDetailsTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//

import UIKit

class NewGoalDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleDetailsLabel: UILabel!
    @IBOutlet weak var detailsTextField: UITextField!
    
    static let identifier: String = String(describing: NewGoalDetailsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
}
