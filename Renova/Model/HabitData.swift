//
//  HabitData.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation

struct HabitData {
    var title: String = ""
    var description: String?
    var daysSelected: [String: String] = ["SEG": "Segunda",
                                          "TER": "Terça",
                                          "QUA": "Quarta",
                                          "QUI": "Quinta",
                                          "SEX": "Sexta",
                                          "SÁB": "Sábado",
                                          "DOM": "Domingo"]
    var deadline: Int = 0
    
    init() {}
}
