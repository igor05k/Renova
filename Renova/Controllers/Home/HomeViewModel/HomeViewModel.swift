//
//  HomeViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 02/02/23.
//

import Foundation

struct HomeViewModel {
    private(set) var todaysHabit: [TodaysHabitModel] = []
    private(set) var weeklyHabits: [DuringWeekHabitsModel] = [.init(title: "Finalizar meu projeto", daysOfTheWeek: ["SEG", "TER", "SÁB", "DOM"], markAsCompleted: ["SEG"])]
    
    mutating public func setTodaysHabit(data: TodaysHabitModel) {
        todaysHabit.append(data)
    }
    
    mutating public func setWeeklyHabit(data: DuringWeekHabitsModel) {
        weeklyHabits.append(data)
    }
}
