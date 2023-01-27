//
//  NewGoalDetailsTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//

import UIKit

class NewGoalDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleDetailsLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    static let identifier: String = String(describing: NewGoalDetailsTableViewCell.self)
    
    var didChangeTitle: ((_ title: String) -> Void)?
    var didChangeDescription: ((_ title: String?) -> Void)?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        layer.cornerRadius = 10.0
        clipsToBounds = true
        configElements()
    }
    
    func configElements() {
        titleDetailsLabel.text = "Título"
        titleTextField.placeholder = "Correr 5km"
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = CGColor(red: 128 / 255, green: 120 / 255, blue: 115 / 255, alpha: 1)
        titleTextField.layer.cornerRadius = 5
        
        descriptionLabel.text = "Descrição"
        descriptionTextField.placeholder = "Treinar e correr todos os dias (opcional)"
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.layer.borderColor = CGColor(red: 128 / 255, green: 120 / 255, blue: 115 / 255, alpha: 1)
        descriptionTextField.layer.cornerRadius = 5
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        
    }
}

extension NewGoalDetailsTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            if let title = textField.text {
                didChangeTitle?(title)
            }
        } else if textField == descriptionTextField {
            didChangeDescription?(textField.text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            descriptionTextField.becomeFirstResponder()
        } else if textField == descriptionTextField {
            descriptionTextField.resignFirstResponder()
        }
        return true
    }
}
