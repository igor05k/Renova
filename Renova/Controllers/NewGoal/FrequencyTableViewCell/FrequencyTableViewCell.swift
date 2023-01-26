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
    
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setupSegmentedControl()
        layer.cornerRadius = 10.0
        clipsToBounds = true
        selectionStyle = .none
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DaysOfTheWeekCollectionViewCell.nib(), forCellWithReuseIdentifier: DaysOfTheWeekCollectionViewCell.identifier)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitle("Diariamente", forSegmentAt: 0)
        segmentedControl.setTitle("Prazo", forSegmentAt: 1)
        
        datePicker.isHidden = true
        sliderContainerView.isHidden = true
        
        
        let tomorrow = Date(timeIntervalSinceNow: 90000)
        datePicker.minimumDate = tomorrow
        
        deadlineLabel.text = "Escolha uma data"
        deadlineLabel.numberOfLines = 0
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let now = Date()
        let timeRemaining = sender.date.timeIntervalSince(now)
        // convert to days
        let days = Int(timeRemaining / 86400)
        
        if days == 1 {
            deadlineLabel.text = "Tempo restante \n\(days) dia"
        } else {
            deadlineLabel.text = "Tempo restante \n\(days) dias"
        }
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            collectionView.isHidden = false
            datePicker.isHidden = true
            sliderContainerView.isHidden = true
        case 1:
            collectionView.isHidden = true
            datePicker.isHidden = false
            sliderContainerView.isHidden = false
        default:
            break
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
