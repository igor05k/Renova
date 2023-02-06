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
    
    private(set) var weeklyHabits: [DuringWeekHabitsModel] = [.init(title: "Finalizar meu projeto", daysOfTheWeek: ["SEG", "TER", "SÁB", "DOM"], markAsCompleted: ["SEG"]),
                                                              .init(title: "Academia", daysOfTheWeek: ["SEG", "TER", "QUA", "QUI", "SEX"], markAsCompleted: ["SEG", "TER", "QUA"])]
    
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
    
    func checkIfTodaysHabitIsEmpty() {
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("habits").getDocuments { [weak self] snapshot, error in
            if let error {
                print("Error getting documents: \(error)")
            } else {
                let count = snapshot?.documents.count ?? 0
                print(count)
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
