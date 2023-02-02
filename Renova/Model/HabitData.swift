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
    var daysSelected: [String: String]?
    var deadline: Date?
    var time: String? = "No notifications"
    
    init() {
        self.title = ""
        self.description = ""
        self.habitImage = ""
        self.deadline = nil
        /// dias selecionados precisa ser inicializado com valors pois o primeiro segmento é o de 'dias da semana'. se o valor inicial for nil, ele irá cair na mensagem
        /// de erro de 'pelo menos um campo de frequencia precisa ser selecionado'. sendo assim, por padrão, dias selecionados precisa ser inicializado com valores
        /// o que não exclui essa propriedade de ser nil
        self.daysSelected = ["SEG": "Segunda",
                             "TER": "Terça",
                             "QUA": "Quarta",
                             "QUI": "Quinta",
                             "SEX": "Sexta",
                             "SÁB": "Sábado",
                             "DOM": "Domingo"]
    }
}
