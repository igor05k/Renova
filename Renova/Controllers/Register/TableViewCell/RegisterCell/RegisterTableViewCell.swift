//
//  RegisterTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    static let identifier: String = String(describing: RegisterTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(form: Forms) {
        textFieldLabel.text = form.formName
        textField.placeholder = form.formPlaceholder
    }
}
