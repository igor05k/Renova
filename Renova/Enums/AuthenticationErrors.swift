//
//  LoginErrors.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import Foundation

enum AuthenticationErrors: LocalizedError {
    case noInput
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case invalidPasswordFormattation
    case wrongPassword
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
        case .noInput:
            return "Campos vazios"
        case .emptyEmail:
            return "Email vazio"
        case .invalidEmail:
            return "Email inválido"
        case .emptyPassword:
            return "Senha vazia"
        case .invalidPasswordFormattation:
            return "Senha não cumpre os requisitos mínimos"
        case .wrongPassword:
            return "Senha inválida ou o usuário não tem uma senha"
        case .passwordsDoNotMatch:
            return "As senhas devem ser iguais"
        }
    }
}
