//
//  ProgressCardTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 29/01/23.
//

import UIKit

class ProgressCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressViewContainr: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let identifier: String = String(describing: ProgressCardTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressViewContainr.backgroundColor = .clear
        backgroundColor = .backgroundSecondary.withAlphaComponent(0.3)
        layer.cornerRadius = 10
        selectionStyle = .none
        setupProgressView()
        setupProgressLabel()
    }
    
    private func setupProgressLabel() {
        progressLabel.text = "82%"
        progressLabel.textColor = UIColor.gray
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        titleLabel.text = "Resumo"
        titleLabel.textColor = .init(red: 64 / 255, green: 60 / 255, blue: 57 / 255, alpha: 1)
        
        subtitleLabel.text = "Você está quase lá. Continue se desafiando"
        subtitleLabel.textColor = .init(red: 128 / 255, green: 120 / 255, blue: 115 / 255, alpha: 1)
    }

    private func setupProgressView() {
        // Create a circular path for the track layer
        let circularPath = UIBezierPath(arcCenter: .init(x: (progressViewContainr.frame.width / 2), y: (progressViewContainr.frame.height / 2)), radius: 50, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
      
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = .init(red: 191 / 255, green: 180 / 255, blue: 172 / 255, alpha: 1)
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 6
        progressViewContainr.layer.addSublayer(trackLayer)

        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = .init(red: 64 / 255, green: 60 / 255, blue: 57 / 255, alpha: 1)
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 8
        progressLayer.strokeEnd = 0
        progressViewContainr.layer.addSublayer(progressLayer)

        
        // Update the progress of the progress layer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0.8
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "animation")
    }
}

