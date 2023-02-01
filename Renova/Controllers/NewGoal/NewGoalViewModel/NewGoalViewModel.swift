//
//  NewGoalViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation
import FirebaseFirestore

enum CreateAGoalErrors: LocalizedError {
    case emptyTitle
    case emptyFrequency
    case emptyHabitImage
    case emptyDescription
    
    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Título obrigatório"
        case .emptyFrequency:
            return "Pelo menos um campo de frequência deve ser preenchido"
        case .emptyHabitImage:
            return "Você precisa escolher uma imagem para seu hábito"
        case .emptyDescription:
            return "Descrição obrigatória"
        }
    }
}

struct NewGoalViewModel {
    
    var onEmptyFrequency: (() -> Void)?
    var onEmptyTitle: (() -> Void)?
    var onEmptyHabitImage: (() -> Void)?
    var onEmptyDescription: (() -> Void)?
    
//    var onSuccesfulSave: ((_ data: HabitData) -> Void)?
    
    func createNewHabit(title: String, description: String, days: [String: String], deadline: Date?, time: String?, habitImage: String) {

        guard let titleUnwrapped = try? checkIfTitleItsEmpty(title) else { return }
        guard let descUnwrapped = try? checkIfDescriptionItsEmpty(description) else { return }
        guard let deadlineUnwrapped = try? checkIfFrequencyItsEmpty(days, deadline ?? nil) else { return }
        guard let imageUnwrapped = try? checkIfHabitImageItsEmpty(habitImage) else { return }
        
        var habit = HabitData()
        habit.title = titleUnwrapped
        habit.description = descUnwrapped
        habit.time = time
        habit.daysSelected = deadlineUnwrapped.0
        habit.deadline = deadlineUnwrapped.1
        habit.habitImage = imageUnwrapped
        
        print(habit)
        
        // if start new flow, pass info forward; otherwise save right here in firebase
//        onSuccesfulSave?(habit)
        
    }
    
    // MARK: Firebase
    
    /// save data into firestore
    func saveNewHabitData(_ name: String, _ description: String) {
        let db = Firestore.firestore()
        
        let newHabit = ["name": "Novo Exercicio", "description": "Caminhada", "startDate": "2023-01-01", "endDate": "2023-12-31"]
        // create a new collection of goals/add a new goal into the collection
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("goals").document().setData(newHabit)
        
        
        // create progress collection/ access goal collection so we can track the specific goal progress
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("goals").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    
                    let exerciseName = data["name"] as! String
                    let date = data["startDate"] as! String
                    // do something with the data
                    let progress = ["name": exerciseName, "goalID": document.documentID, "description": "Exercise for 30 minutes every day", "startDate": date, "progress": "30"]
                    db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("progress").document().setData(progress)
                    break
                }
            }
        }
    }
    
    
    // MARK: Error handling
    func checkIfDescriptionItsEmpty(_ description: String) throws -> String {
        do {
            if description.isEmpty {
                onEmptyDescription?()
                throw CreateAGoalErrors.emptyDescription
            }
        } catch {
            throw error
        }
        
        return description
    }
    
    func checkIfHabitImageItsEmpty(_ image: String) throws -> String {
        do {
            if image.isEmpty {
                onEmptyHabitImage?()
                throw CreateAGoalErrors.emptyHabitImage
            }
        } catch {
            throw error
        }
        
        return image
    }
    
    func checkIfFrequencyItsEmpty(_ days: [String: String], _ deadline: Date?) throws -> ([String: String], Date?) {
        do {
            if days.isEmpty && deadline == nil {
                onEmptyFrequency?()
                throw CreateAGoalErrors.emptyFrequency
            }
        } catch {
            throw error
        }
        
        return (days, deadline)
    }
    
    func checkIfTitleItsEmpty(_ title: String) throws -> String {
        do {
            if title.isEmpty {
                onEmptyTitle?()
                throw CreateAGoalErrors.emptyTitle
            }
        } catch {
            throw error
        }
        
        return title
    }
}
