//
//  UIColor+.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import UIKit

extension UIColor {
    static var viewBackgroundColor: UIColor {
        return UIColor(named: "backgroundDefault") ?? .black
    }
    
    static var backgroundPrimary: UIColor {
        return UIColor(named: "backgroundPrimary") ?? .black
    }
    
    static var backgroundSecondary: UIColor {
        return UIColor(named: "backgroundSecondary") ?? .black
    }
}
