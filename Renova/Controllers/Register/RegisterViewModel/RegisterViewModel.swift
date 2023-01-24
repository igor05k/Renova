//
//  RegisterViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import Foundation
import FirebaseAuth

protocol LoadingDelegate: AnyObject {
    func manageLoading(didChangeLoadingState isLoading: Bool)
}

protocol RegisterViewModelProtocol {
    func createAccount(_ name: String, _ email: String, _ password: String, _ passwordConfirmation: String, completion: @escaping ((Bool) -> Void))
    var showInvalidPasswordAlertError: (() -> Void)? { get set }
    var onRegistrationFailed: ((_ err: Error) -> Void)? { get set }
    var emailAlreadyInUse: ((_ err: Error?) -> Void)? { get set }
    var unexpectedError: ((_ err: Error?) -> Void)? { get set }
}

final class RegisterViewModel: RegisterViewModelProtocol {
    private let auth = Auth.auth()
    var onRegistrationFailed: ((_ err: Error) -> Void)?
    var emailAlreadyInUse: ((_ err: Error?) -> Void)?
    var unexpectedError: ((_ err: Error?) -> Void)?
    
    var showInvalidPasswordAlertError: (() -> Void)?
    
    weak var delegate: LoadingDelegate?
        var isLoading = false {
            didSet {
                delegate?.manageLoading(didChangeLoadingState: isLoading)
            }
        }
    
    func createAccount(_ name: String,
                       _ email: String,
                       _ password: String,
                       _ passwordConfirmation: String,
                       completion: @escaping ((Bool) -> Void)) {
        isLoading = true
        func checkEmail() throws -> String {
            do {
                if email.isEmpty {
                    isLoading = false
                    completion(false)
                    throw AuthenticationErrors.emptyEmail
                }
                
                if !email.contains("@") || !email.contains(".") {
                    isLoading = false
                    completion(false)
                    throw AuthenticationErrors.invalidEmail
                }
            } catch {
                onRegistrationFailed?(error)
                isLoading = false
                completion(false)
                throw error
            }
            
            return email
        }
        
        func checkPassword() throws -> String {
            do {
                if password.isEmpty {
                    isLoading = false
                    completion(false)
                    throw AuthenticationErrors.emptyPassword
                }
                
                if password != passwordConfirmation {
                    isLoading = false
                    completion(false)
                    throw AuthenticationErrors.passwordsDoNotMatch
                }
                
                if !RegExp.checkPasswordComplexity(password: password, length: 8, patternsToEscape: [], caseSensitivty: true, numericDigits: true, specialCharacter: true) {
                    isLoading = false
                    completion(false)
                    throw AuthenticationErrors.invalidPasswordFormattation
                }
            } catch {
                onRegistrationFailed?(error)
                isLoading = false
                completion(false)
                throw error
            }

            return password
        }
        
        guard let email = try? checkEmail() else { return }
        guard let password = try? checkPassword() else { return }
        
        if !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && !name.isEmpty {
            Auth.auth().fetchSignInMethods(forEmail: email) { [weak self] (methods, error) in
                if let error = error {
                    self?.unexpectedError?(error)
                } else if methods == nil {
                    // email is not in use - call signin
                    self?.auth.createUser(withEmail: email, password: password, completion: { _, error in
                        if error != nil {
                            self?.unexpectedError?(error)
                            self?.isLoading = false
                            completion(false)
                        } else {
                            self?.isLoading = false
                            completion(true)
                        }
                    })
                } else {
                    self?.isLoading = false
                    completion(false)
                    self?.emailAlreadyInUse?(error)
                }
            }
        }
    }
}
