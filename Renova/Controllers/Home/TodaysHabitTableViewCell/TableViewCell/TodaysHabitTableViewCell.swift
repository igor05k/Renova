//
//  TodaysHabitTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 29/01/23.
//

import UIKit

class TodaysHabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let colors: [UIColor] = [.cellbg1, .cellbg2, .cellbg3, .cellbg4, .cellbg5, .cellbg6, .cellbg7]
    private var todaysHabit: [TodaysHabitModel] = []
    
    static let identifier: String = String(describing: TodaysHabitTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView()
        selectionStyle = .none
    }

    func configCollectionView() {
        collectionView.delegate = self
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 10, left: 5, bottom: 0, right: 5)
        collectionView.register(TodaysHabitCollectionViewCell.nib(), forCellWithReuseIdentifier: TodaysHabitCollectionViewCell.identifier)
    }
    
    public func configure(model: [TodaysHabitModel]) {
        self.todaysHabit = model
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension TodaysHabitTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysHabitCollectionViewCell.identifier, for: indexPath) as? TodaysHabitCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(model: todaysHabit[indexPath.row])
        //  if indexPath.row is 7 and colors.count is 5, 7 % 5 equals 2, so colors[2] will be used as the background color.
        cell.backgroundColor = colors[indexPath.row % colors.count].withAlphaComponent(0.3)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysHabit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if todaysHabit.count <= 2 {
            return CGSize(width: (collectionView.frame.width / 2) - 10, height: (collectionView.frame.height / 2) + 75)
        }
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: (collectionView.frame.height / 2) + 10)
    }
}
