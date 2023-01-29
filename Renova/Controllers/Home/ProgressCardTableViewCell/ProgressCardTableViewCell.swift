//
//  ProgressCardTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 29/01/23.
//

import UIKit

class ProgressCardTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ProgressCardTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .backgroundSecondary.withAlphaComponent(0.3)
        layer.cornerRadius = 10
        selectionStyle = .none
    }
}
