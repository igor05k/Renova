//
//  HabitImagesCollectionViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

struct HabitImages {
    var image: String = ""
    var isSelected: Bool = false
}

class HabitImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var habitImageView: UIImageView!
    
    var isSelectedImage: Bool = false
    
    var habitImages: HabitImages = HabitImages()
    
    var didTapHabitImageView: ((_ cell: UICollectionViewCell) -> Void)?
    
    static let identifier: String = String(describing: HabitImagesCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configHabitImage()
        habitImageView.alpha = 0.5
    }
    
    private func configHabitImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        habitImageView.isUserInteractionEnabled = true
        habitImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageTapped() {
        didTapHabitImageView?(self)
    }
    
    func setupCell(habitImage: HabitImages) {
        habitImageView.image = UIImage(named: habitImage.image)
        isSelectedImage = habitImage.isSelected  
        
//        if isSelectedImage {
//            habitImageView.alpha = 1
//        } else {
//            habitImageView.alpha = 0.5
//        }
    }
}

