//
//  FrequencyTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//

import UIKit

class FrequencyTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: FrequencyTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sliderElement: UISlider!
    
    @IBOutlet weak var weeksLabel: UILabel!
    
    @IBOutlet weak var sliderContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setupSegmentedControl()
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DaysOfTheWeekCollectionViewCell.nib(), forCellWithReuseIdentifier: DaysOfTheWeekCollectionViewCell.identifier)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitle("Diariamente", forSegmentAt: 0)
        segmentedControl.setTitle("Semanalmente", forSegmentAt: 1)
        
        sliderElement.isHidden = true
        sliderContainerView.isHidden = true
        
        weeksLabel.text = "1 semana"
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            collectionView.isHidden = false
            sliderElement.isHidden = true
            sliderContainerView.isHidden = true
        case 1:
            collectionView.isHidden = true
            sliderElement.isHidden = false
            sliderContainerView.isHidden = false
        default:
            break
        }
    }
    
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let value = Int(sender.value)
        if value == 1 {
            weeksLabel.text = String("\(value) semana")
        } else {
            weeksLabel.text = String("\(value) semanas")
        }
    }
}

extension FrequencyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysOfTheWeekCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
}
