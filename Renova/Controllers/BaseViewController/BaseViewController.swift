//
//  BaseViewController.swift
//  Renova
//
//  Created by Igor Fernandes on 29/01/23.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func resignKeyboard() {
        view.endEditing(true)
    }
}

