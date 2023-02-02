//
//  FrequencyTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 25/01/23.
//

import UIKit
import FirebaseFirestore

enum DaysOfTheWeek: String, CaseIterable {
    case monday = "SEG"
    case tuesday = "TER"
    case wednesday = "QUA"
    case thursday = "QUI"
    case friday = "SEX"
    case saturday = "SÁB"
    case sunday = "DOM"
    
    static func selectDay(at index: Int) -> DaysOfTheWeek {
        return DaysOfTheWeek.allCases[index]
    }
    
    static func convertDay(rawValue: String) -> String? {
        switch rawValue {
        case "SEG": return "Segunda"
        case "TER": return "Terça"
        case "QUA": return "Quarta"
        case "QUI": return "Quinta"
        case "SEX": return "Sexta"
        case "SÁB": return "Sábado"
        case "DOM": return "Domingo"
        default: return nil
        }
    }
}

enum SegmentSelected: Int {
    case daily = 0
    case deadline = 1
}

class FrequencyTableViewCell: UITableViewCell {
    
    // preciso usar dict pois array utiliza index e nesse caso queremos usar chave-valor para selecionar e remover
    // os items precisamente
    var daysOfTheWeekDict: [String: String] = ["SEG": "Segunda",
                                               "TER": "Terça",
                                               "QUA": "Quarta",
                                               "QUI": "Quinta",
                                               "SEX": "Sexta",
                                               "SÁB": "Sábado",
                                               "DOM": "Domingo"]
    
    /// os dois segmentos (dias da semana e prazo) precisam ser opcionais pois somente um dos dois será selecionado. porém, um deve ser escolhido
    var daysSelected: ((_ days: [String: String]?) -> Void)?
    var deadlineSelected: ((_ days: Date?) -> Void)?
    var numberOfDaysChosen: ((_ days: Int) -> Void)?
    
    /// isso é necessário para rastrear o número de dias selecionado no prazo porque assim, quando o usuário sai do segmento de prazo e volta, o número ainda está lá.
    private var numberOfDays: Int = 0
    private var deadline: Date?
    
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
        segmentedControl.setTitle("Dias da semana", forSegmentAt: 0)
        segmentedControl.setTitle("Prazo", forSegmentAt: 1)
        
        segmentedControl.backgroundColor = .backgroundSecondary
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.backgroundPrimary], for: .normal)
        
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
        numberOfDays = days
        deadline = sender.date
        
        // é necessário enviar o sender.date para salvar como timestamp no firebase
        if days == 1 {
            deadlineSelected?(sender.date)
            deadlineLabel.text = "Tempo restante \n\(days) dia"
        } else {
            deadlineSelected?(sender.date)
            deadlineLabel.text = "Tempo restante \n\(days) dias"
        }
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case SegmentSelected.daily.rawValue:
            collectionView.isHidden = false
            datePicker.isHidden = true
            sliderContainerView.isHidden = true
            
            // reseta os valores quando muda de segmento
            numberOfDaysChosen?(0)
            deadlineSelected?(nil)
            daysSelected?(daysOfTheWeekDict)
        case SegmentSelected.deadline.rawValue:
            collectionView.isHidden = true
            datePicker.isHidden = false
            sliderContainerView.isHidden = false
            
            // reseta os valores quando muda de segmento
            numberOfDaysChosen?(numberOfDays)
            deadlineSelected?(deadline)
            daysSelected?(nil)
        default:
            break
        }
    }
}

extension FrequencyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysOfTheWeekCollectionViewCell.identifier, for: indexPath) as? DaysOfTheWeekCollectionViewCell else { return UICollectionViewCell() }
        cell.setupLabels(daysOfTheWeek: DaysOfTheWeek.allCases[indexPath.row].rawValue)
        cell.didChangeDays = { [weak self] cell in
            guard let dayIndex = collectionView.indexPath(for: cell) else { return }
            
            if let self {
                let choosedDay = DaysOfTheWeek.selectDay(at: dayIndex.row).rawValue
                
                // busca por dias repetidos e os remove
                if self.daysOfTheWeekDict.contains(where: { $0.key == choosedDay }) {
                    self.daysOfTheWeekDict.removeValue(forKey: choosedDay)
                    self.daysSelected?(self.daysOfTheWeekDict)
                } else {
                    guard let dayToUpdate = DaysOfTheWeek.convertDay(rawValue: choosedDay) else { return }
                    self.daysOfTheWeekDict.updateValue(dayToUpdate, forKey: choosedDay)
                    self.daysSelected?(self.daysOfTheWeekDict)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DaysOfTheWeek.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
}
