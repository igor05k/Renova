//
//  HabitData.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation

// somente timer (notificacoes) opcional

struct HabitData {
    var title: String
    var description: String
    var habitImage: String
    var daysSelected: [String: String]
    var deadline: Date?
    var time: String? = "No notifications"
    
    init() {
        self.title = ""
        self.description = ""
        self.habitImage = ""
        self.deadline = nil
        self.daysSelected = ["SEG": "Segunda",
                             "TER": "Terça",
                             "QUA": "Quarta",
                             "QUI": "Quinta",
                             "SEX": "Sexta",
                             "SÁB": "Sábado",
                             "DOM": "Domingo"]
    }
}
