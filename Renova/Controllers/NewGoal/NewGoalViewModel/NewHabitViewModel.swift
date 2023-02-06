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

struct NewHabitViewModel {
    
    var onEmptyFrequency: (() -> Void)?
    var onEmptyTitle: (() -> Void)?
    var onEmptyHabitImage: (() -> Void)?
    var onEmptyDescription: (() -> Void)?
    
    var onSuccessfulSaveHabit: ((_ data: HabitData) -> Void)?
    
    func createNewHabit(title: String, description: String, days: [String: String]?, deadline: Date?, time: String?, habitImage: String) {

        guard let titleUnwrapped = try? checkIfTitleItsEmpty(title) else { return }
        guard let descUnwrapped = try? checkIfDescriptionItsEmpty(description) else { return }
        guard let deadlineUnwrapped = try? checkIfFrequencyItsEmpty(days ?? nil, deadline ?? nil) else { return }
        guard let imageUnwrapped = try? checkIfHabitImageItsEmpty(habitImage) else { return }
       
        saveNewHabitData(titleUnwrapped, descUnwrapped, daysOfTheWeek: deadlineUnwrapped.0 ?? nil, deadline: deadlineUnwrapped.1 ?? nil, time: time, habitImage: imageUnwrapped)
        
        var habit = HabitData()
        habit.title = titleUnwrapped
        habit.description = descUnwrapped
        habit.time = time
        habit.daysSelected = deadlineUnwrapped.0
        habit.deadline = deadlineUnwrapped.1
        habit.habitImage = imageUnwrapped
        
        onSuccessfulSaveHabit?(habit)
    }
    
    // MARK: Firebase
    
    /// save data into firestore
    func saveNewHabitData(_ name: String, _ description: String, daysOfTheWeek: [String: String]?, deadline: Date?, time: String?, habitImage: String) {
        let db = Firestore.firestore()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let currentDateString = formatter.string(from: Date())

        // isso é necessario pois caso o deadline nao for setado, ele irá como nulo para o firebase
        // + o parametro date do timestamp não aceita nil.
        let endDate: Timestamp?
        
        if let deadline {
            endDate = Timestamp(date: deadline)
        } else {
            endDate = nil
        }
        
        let newHabit: [String : Any?] = ["name": name, "description": description, "startDate": currentDateString, "endDate": endDate ?? nil, "daysOfTheWeek": daysOfTheWeek, "alert": time ?? nil, "habitImage": habitImage, "markAsCompleted": [String]()]
        
        // create a new collection of habits/add a new habit into the collection
        db.collection("users").document("rAQfrqv6deZUmbMTau6YULZGCJc2").collection("habits").addDocument(data: newHabit as [String : Any])
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
    
    func checkIfFrequencyItsEmpty(_ days: [String: String]?, _ deadline: Date?) throws -> ([String: String]?, Date?) {
        do {
            if days == nil && deadline == nil {
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
