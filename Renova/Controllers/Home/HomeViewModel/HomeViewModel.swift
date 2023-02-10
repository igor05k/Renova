//
//  HomeViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 02/02/23.
//

import Foundation
import FirebaseFirestore

final class HomeViewModel {
    private let db = Firestore.firestore()
    
    var didTodaysHabitReceiveValue: (() -> Void)?
    var onSuccessfulFetch: (() -> Void)?
    
    private(set) var todaysHabit: [TodaysHabitModel] = [] {
        didSet {
            isTodaysHabitEmtpy = false
        }
    }
    
    private(set) var weeklyHabits: [DuringWeekHabitsModel] = [.init(title: "Finalizar meu projeto",
                                                                    daysOfTheWeek: ["SEG": "Segunda",
                                                                                    "TER": "Terça",
                                                                                    "QUA": "Quarta",
                                                                                    "QUI": "Quinta",
                                                                                    "SEX": "Sexta",
                                                                                    "SÁB": "Sábado",
                                                                                    "DOM": "Domingo"],
                                                                    markAsCompleted: ["QUA"])]
    
    private(set) var isTodaysHabitEmtpy: Bool = false
    
    func setTodaysHabit(data: TodaysHabitModel) {
        todaysHabit.append(data)
    }
    
    func setWeeklyHabit(data: DuringWeekHabitsModel) {
        weeklyHabits.append(data)
    }
    
    func fetchTodaysHabit() {
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("habits").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        
                        if let exerciseName = data["name"] as? String,
                           let desc = data["description"] as? String,
                           let habitImage = data["habitImage"] as? String {
                            let todayHabit = TodaysHabitModel(title: exerciseName, description: desc, image: habitImage)
                            self?.todaysHabit.append(todayHabit)
                            self?.onSuccessfulFetch?()
                        }
                    }
                }
            }
        }
    }
    
    func fetchWeeklyHabits() {
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("habits").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        
                        if let habitName = data["name"] as? String,
                           let daysOfTheWeek = data["daysOfTheWeek"] as? [String : String],
                           let markAsCompleted = data["markAsCompleted"] as? [String] {
                            let weeklyHabits = DuringWeekHabitsModel(title: habitName, daysOfTheWeek: daysOfTheWeek, markAsCompleted: markAsCompleted)
                            self?.weeklyHabits.append(weeklyHabits)
                            self?.onSuccessfulFetch?()
                        }
                    }
                }
            }
        }
    }
    
    func checkIfTodaysHabitIsEmpty() {
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("habits").getDocuments { [weak self] snapshot, error in
            if let error {
                print("Error getting documents: \(error)")
            } else {
                let count = snapshot?.documents.count ?? 0
                if count == 0 {
                    self?.isTodaysHabitEmtpy = true
                    self?.onSuccessfulFetch?()
                } else {
                    self?.isTodaysHabitEmtpy = false
                    self?.onSuccessfulFetch?()
                }
            }
        }
    }
}
