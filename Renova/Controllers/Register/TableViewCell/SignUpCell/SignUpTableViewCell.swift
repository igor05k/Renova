//
//  SignUpTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: SignUpTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var signUpButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        signUpButton.setTitle("Registrar", for: .normal)
    }
}
