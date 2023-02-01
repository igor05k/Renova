//
//  HabitData.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation

// titulo, frequencia (daysSelected e deadline) e imagem obrigatorios

struct HabitData {
    var title: String = ""
    var description: String?
    var habitImage: String = ""
    var daysSelected: [String: String] = ["SEG": "Segunda",
                                          "TER": "Terça",
                                          "QUA": "Quarta",
                                          "QUI": "Quinta",
                                          "SEX": "Sexta",
                                          "SÁB": "Sábado",
                                          "DOM": "Domingo"]
    var deadline: Int = 0
    var time: String? = "No notifications"
    
    init() {}
}
