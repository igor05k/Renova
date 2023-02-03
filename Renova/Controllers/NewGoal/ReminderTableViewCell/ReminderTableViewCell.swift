//
//  ReminderTableViewCell.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import UIKit
import UserNotifications


class ReminderTableViewCell: UITableViewCell {
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    static let identifier: String = String(describing: ReminderTableViewCell.self)
    
    var notificationAlarmChanged: ((_ timeRemaining: String?) -> Void)?
    
    private var isNotificationsOn: Bool = false {
        didSet {
            notificationAlarmChanged?(timerPicker.date.formatted())
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        clipsToBounds = true
        selectionStyle = .none
        configElements()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            if granted {
//                let content = UNMutableNotificationContent()
//                content.title = "Alarm"
//                content.body = "Time to wake up"
//                content.sound = UNNotificationSound.default
//
//                let date = DateComponents(second: 5)
//                
//                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
//
//
//                let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request) { ( error) in
//                    if error != nil {
//                        print("Error scheduling notification: \(error?.localizedDescription ?? "")")
//                    } else {
//                        print("Notification scheduled successfully")
//                    }
//                }
            } else {
                print("Permission denied")
            }
        }
    }
    
    private func configElements() {
        notificationsLabel.text = "Notificações"
        timerLabel.text = "Avisar às"
        
        notificationsSwitch.isOn = false
        blurNotifications()
        
        // convert timezone to GMT-3
        let gmtMinus3 = TimeZone(secondsFromGMT: -60 * 60 * 3)
        timerPicker.timeZone = gmtMinus3
    }
    
    private func setNotifications(_ sender: UIDatePicker) {
        // se o horario selecionado for menor que o horario atual, significa que sera agendado para o proximo dia
        if isNotificationsOn {
            let datePicked = sender.date
            
            if datePicked < Date.now {
                let tomorrow = datePicked.addingTimeInterval(86400)
                notificationAlarmChanged?(tomorrow.formatted())
            } else {
                notificationAlarmChanged?(datePicked.formatted())
            }
        }
    }
    
    @IBAction func timerDidChange(_ sender: UIDatePicker) {
        setNotifications(sender)
    }
    
    func blurNotifications() {
        timerLabel.textColor = .lightGray
        timerPicker.isEnabled = false
        timerPicker.addSubview(blurView)
        blurView.alpha = 1
        blurView.frame = timerPicker.bounds
        isNotificationsOn = false
        notificationAlarmChanged?(nil)
    }
    
    @IBAction func notificationsDidChange(_ sender: UISwitch) {
        if sender.isOn {
            blurView.alpha = 0
            timerPicker.isEnabled = true
            timerLabel.textColor = .black
            isNotificationsOn = true
        } else {
            blurNotifications()
        }
    }
}
