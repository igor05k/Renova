//
//  ProgressView.swift
//  Renova
//
//  Created by Igor Fernandes on 27/01/23.
//

import UIKit

class ProgressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .viewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
