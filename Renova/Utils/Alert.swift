//
//  Alert.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

class Alert {
    class func showDefaultAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    class func showDefaultAlertWithAction(title: String, message: String, vc: UIViewController, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            completion(false)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion(true)
        }))
        vc.present(alert, animated: true)
    }
}

