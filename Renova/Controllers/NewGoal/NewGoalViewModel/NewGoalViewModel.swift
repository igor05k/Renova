//
//  NewGoalViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation

struct NewGoalViewModel {
    
    func validadeFields(title: String, description: String, days: [String: String], deadline: Int, time: String?) {
                if days.isEmpty && deadline == 0 {
                    print("IMPOSSIVEL")
                }
        print(title, description, days, deadline, time)
    }
}
