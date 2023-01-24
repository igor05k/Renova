//
//  LoginViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 23/01/23.
//

import Foundation
import FirebaseAuth

final class LoginViewModel {
    var onPasswordWrong: ((_ err: Error) -> Void)?
    private let auth = Auth.auth()
    typealias LoginResult = ((Result<Bool, Error>) -> Void)
    
    weak var delegate: LoadingDelegate?
    
    var isLoading = false {
        didSet {
            delegate?.manageLoading(didChangeLoadingState: isLoading)
        }
    }
    
    /// check if password and email is well-formatted and logs user in
    func signIn(_ email: String, _ password: String, completion: @escaping LoginResult) {
        isLoading = true
        func checkEmail() throws -> String {
            do {
                if email.isEmpty {
                    isLoading = false
                    throw AuthenticationErrors.emptyEmail
                }
                
                if !email.contains("@") || !email.contains(".") {
                    isLoading = false
                    throw AuthenticationErrors.invalidEmail
                }
            } catch {
                isLoading = false
                onPasswordWrong?(error)
                throw error
            }
            
            return email
        }
        
        func checkPassword() throws -> String {
            do {
                if password.isEmpty {
                    isLoading = false
                    throw AuthenticationErrors.emptyPassword
                }
                
                if !RegExp.checkPasswordComplexity(password: password, length: 8, patternsToEscape: [], caseSensitivty: true, numericDigits: true, specialCharacter: true) {
                    isLoading = false
                    throw AuthenticationErrors.invalidPasswordFormattation
                }
            } catch {
                isLoading = false
                onPasswordWrong?(error)
                throw error
            }

            return password
        }
        
        guard let email = try? checkEmail() else { return }
        guard let password = try? checkPassword() else { return }
        
        if !email.isEmpty && !password.isEmpty {
            try? login(with: email, password: password) { [weak self] result in
                switch result {
                case .success(_):
                    completion(.success(true))
                    self?.isLoading = false
                case .failure(let failure):
                    completion(.failure(failure))
                    self?.isLoading = false
                }
            }
        }
    }
    
    /// authentication via firebase
    private func login(with email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) throws {
        auth.signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            // since we cant verify if the users password does exists in the database - only firebase can do this
            // we need to handle this case inside the signIn method by firebase
            if error != nil {
                do {
                    throw AuthenticationErrors.wrongPassword
                } catch {
                    self?.isLoading = false
                    self?.onPasswordWrong?(error)
                }
            } else {
                completion(.success(true))
            }
        }
    }
}
