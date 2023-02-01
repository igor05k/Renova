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
    
    private var selectedCellIndex: Int?
    
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
}

extension ChooseImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImagesCollectionViewCell.identifier, for: indexPath) as? HabitImagesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupCell(habitImage: habitImages[indexPath.row])
        
        /// closure para pegar o tap na célula de imagem para o hábito
        cell.didTapHabitImageView = { [weak self] cellSelected in
            guard let self else { return }
            guard let index = collectionView.indexPath(for: cellSelected) else { return }
            var selectedItem = self.habitImages[index.row]

            // como nenhum item por padrão virá como true, ele não irá cair na primeira condicional
            // logo irá para o else e setará o alpha para 1
            if selectedItem.isSelected == true {
                cell.habitImageView.alpha = 0.5
                selectedItem.isSelected = false
                self.selectedCellIndex = nil
            } else {
                // se existir um item anterior selecionado, deselecione ele
                if let selectedCellIndex = self.selectedCellIndex {
                    let previousSelectedCell = collectionView.cellForItem(at: IndexPath(row: selectedCellIndex, section: 0)) as? HabitImagesCollectionViewCell
                    previousSelectedCell?.habitImageView.alpha = 0.5
                    self.habitImages[selectedCellIndex].isSelected = false
                }
                // destaque e selecione o item atual
                // claro que se o item selecionado for mesmo que o anterior, a prioridade é de manter o atual, logo
                // o alpha será setado para 1
                cell.habitImageView.alpha = 1
                selectedItem.isSelected = true
                self.selectedCellIndex = index.row
            }

            print(selectedItem)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}
