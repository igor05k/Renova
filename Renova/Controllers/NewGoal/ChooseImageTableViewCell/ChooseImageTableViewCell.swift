//
//  ChooseImageTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 30/01/23.
//

import UIKit

class ChooseImageTableViewCell: UITableViewCell {
    
    private var habitImages: [HabitImages] = [.init(image: "bike", isSelected: false),
                                      .init(image: "running", isSelected: false),
                                      .init(image: "bike", isSelected: false),
                                      .init(image: "bike", isSelected: false),
                                      .init(image: "running", isSelected: false),
                                      .init(image: "bike", isSelected: false),
                                      .init(image: "running", isSelected: false),
                                      .init(image: "running", isSelected: false)]
    
    private var selectedHabitImage: [HabitImages] = []
    
    var selectedHabitImages = [Int: Bool]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier: String = String(describing: ChooseImageTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.register(HabitImagesCollectionViewCell.nib(), forCellWithReuseIdentifier: HabitImagesCollectionViewCell.identifier)
    }
    
    func unhighlightNonSelectedCells() {
        for (index, habitImage) in habitImages.enumerated() {
            if let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? HabitImagesCollectionViewCell, !selectedHabitImages[index, default: false] {
                cell.habitImageView.alpha = 0.5
            }
        }
    }
}

extension ChooseImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImagesCollectionViewCell.identifier, for: indexPath) as? HabitImagesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupCell(habitImage: habitImages[indexPath.row])
        
        cell.didTapHabitImageView = { [weak self] cellSelected, isSelectedImage in
            guard let self else { return }
            guard let index = collectionView.indexPath(for: cellSelected) else { return }
            var selectedItem = self.habitImages[index.row]
            selectedItem.isSelected = isSelectedImage
            self.habitImages[index.row] = selectedItem
            
            if selectedItem.isSelected == true {
                cell.habitImageView.alpha = 1
            } else {
                cell.habitImageView.alpha = 0.5
            }
            
            print(selectedItem)
        }

        return cell
    }
    
    
    
    //            if let row = self.habitImages.firstIndex(where: { habitDate.image == $0.image }) {
    //                self.habitImages[row] = habitDate
    //                print("habitDate=======", habitDate)
    //            }
    
    //        cell.setupCell(habitImage: habitImages[indexPath.row])
//
//        cell.didTapHabitImageView = { cellSelected in
//            guard let index = collectionView.indexPath(for: cellSelected) else { return }
//            var selectedItem = self.habitImages[index.row]
//            selectedItem.isSelected = !selectedItem.isSelected
//
//            if !selectedItem.isSelected {
//                cell.habitImageView.alpha = 0.5
//            } else if selectedItem.isSelected {
//                cell.habitImageView.alpha = 1
//                // deselect all other images that is not highlighted
//                collectionView.visibleCells.forEach {
//                    if let habitImageCell = $0 as? HabitImagesCollectionViewCell, habitImageCell !== cellSelected {
//                        habitImageCell.habitImageView.alpha = 0.5
//                    }
//                }
//            }
//        }
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitImagesCollectionViewCell", for: indexPath) as! HabitImagesCollectionViewCell
//        let habitImage = habitImages[indexPath.row]
//        cell.setupCell(habitImage: habitImage)
//
//        cell.habitImageView.alpha = habitImage.isSelected ? 1 : 0.5
//
//        cell.didTapHabitImageView = { cellSelected in
//            guard let index = collectionView.indexPath(for: cellSelected) else { return }
//            var selectedItem = self.habitImages[index.row]
//            selectedItem.isSelected = !selectedItem.isSelected
//
//            if !selectedItem.isSelected {
//                cell.habitImageView.alpha = 0.5
//            } else {
//                cell.habitImageView.alpha = 1
//                // deselect all other images that are not highlighted
//                collectionView.visibleCells.forEach {
//                    if let habitImageCell = $0 as? HabitImagesCollectionViewCell, habitImageCell !== cellSelected {
//                        habitImageCell.habitImageView.alpha = 0.5
//                    }
//                }
//            }
//
//            print("HABIT IMAGE", selectedItem)
//        }
//
//        habitImages = habitImages.map {
//            var habitImage = $0
//            habitImage.isSelected = false
//            return habitImage
//        }
//
//        print("HABIT IMAGE", habitImage)
//
//        return cell
//
////        let habitImage = habitImages[indexPath.row]
////        cell.setupCell(habitImage: habitImage)
////        cell.habitImageView.alpha = habitImage.isSelected ? 1 : 0.5
////        cell.didTapHabitImageView = { [weak self] cellSelected in
////            guard let index = collectionView.indexPath(for: cellSelected) else { return }
////            let selectedItem = self?.habitImages[index.row]
////            self?.habitImages[index.row].isSelected.toggle()
////
////            collectionView.reloadData()
////        }
////
////        return cell
//
//    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var habit = habitImages[indexPath.row]
//        habit.isSelected = true
//        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}
