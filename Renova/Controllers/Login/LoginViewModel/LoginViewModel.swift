//
//  LoginViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import Foundation
import FirebaseAuth

struct LoginViewModel {
    var onPasswordWrong: ((_ err: Error) -> Void)?
    private let auth = Auth.auth()
    typealias LoginResult = ((Result<Bool, Error>) -> Void)
    
    
    /// check if password and email is well-formatted and logs user in
    func signIn(_ email: String, _ password: String, completion: @escaping LoginResult) {
        func checkEmail() throws -> String {
            do {
                if email.isEmpty {
                    throw LoginErrors.emptyEmail
                }
                
                if !email.contains("@") || !email.contains(".") {
                    throw LoginErrors.invalidEmail
                }
            } catch {
                onPasswordWrong?(error)
            }
            
            return email
        }
        
        func checkPassword() throws -> String {
            do {
                if password.isEmpty {
                    throw LoginErrors.emptyPassword
                }
                
                if !RegExp.checkPasswordComplexity(password: password, length: 8, patternsToEscape: [], caseSensitivty: true, numericDigits: true, specialCharacter: true) {
                    throw LoginErrors.invalidPasswordFormattation
                }
            } catch {
                onPasswordWrong?(error)
            }

            return password
        }
        
        guard let email = try? checkEmail() else { return }
        guard let password = try? checkPassword() else { return }
        
        if !email.isEmpty && !password.isEmpty {
            try? login(with: email, password: password) { result in
                switch result {
                case .success(_):
                    completion(.success(true))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    /// authentication via firebase
    private func login(with email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) throws {
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            // since we cant verify if the users password does exists in the database - only firebase can do this
            // we need to handle this case inside the signIn method by firebase
            if error != nil {
                do {
                    throw LoginErrors.wrongPassword
                } catch {
                    onPasswordWrong?(error)
                }
            } else {
                completion(.success(true))
            }
        }
    }
}
