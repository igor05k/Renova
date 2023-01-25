//
//  HomeView.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import UIKit

class HomeView: UIView {
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("See id", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setupbutton()
    }
    
    func setupbutton() {
        addSubview(button)
        button.addTarget(self, action: #selector(getId), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    @objc func getId() {
        print(String(describing: UserId.shared.userId))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
