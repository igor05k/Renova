//
//  NewGoalViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 26/01/23.
//

import Foundation

enum CreateAGoalErrors: LocalizedError {
    case emptyTitle
    case emptyFrequency
    case emptyHabitImage
    
    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Título obrigatório"
        case .emptyFrequency:
            return "Pelo menos um campo de frequência deve ser preenchido"
        case .emptyHabitImage:
            return "Você precisa escolher uma imagem para seu hábito"
        }
    }
}

struct NewGoalViewModel {
    
    var onEmptyFrequency: (() -> Void)?
    var onEmptyTitle: (() -> Void)?
    var onEmptyHabitImage: (() -> Void)?
    
    var onSuccesfulSave: ((_ data: HabitData) -> Void)?
    
    func validadeFields(title: String, description: String, days: [String: String], deadline: Int, time: String?, habitImage: String) {

        guard let deadlineUnwrapped = try? checkIfFrequencyItsEmpty(days, deadline) else { return }
        guard let titleUnwrapped = try? checkIfTitleItsEmpty(title) else { return }
        guard let imageUnwrapped = try? checkIfHabitImageItsEmpty(habitImage) else { return }
        
        var habit = HabitData()
        habit.title = titleUnwrapped
        habit.description = description
        habit.time = time
        habit.daysSelected = deadlineUnwrapped.0
        habit.deadline = deadlineUnwrapped.1
        habit.habitImage = imageUnwrapped
        
        print(habit)
        
        // if start new flow, pass info forward; otherwise save right here in firebase
//        onSuccesfulSave?(habit)
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
    
    func checkIfFrequencyItsEmpty(_ days: [String: String], _ deadline: Int) throws -> ([String: String], Int) {
        do {
            if days.isEmpty && deadline == 0 {
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
