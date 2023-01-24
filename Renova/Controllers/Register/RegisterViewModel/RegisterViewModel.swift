//
//  RegisterViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

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
    
    private var firestore: Firestore = Firestore.firestore()
    
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
            /// check if email already exists
            Auth.auth().fetchSignInMethods(forEmail: email) { [weak self] (methods, error) in
                if let error = error {
                    self?.unexpectedError?(error)
                } else if methods == nil {
                    // email is not in use - call signin
                    self?.auth.createUser(withEmail: email, password: password, completion: { result, error in
                        if error != nil {
                            self?.unexpectedError?(error)
                            self?.isLoading = false
                            completion(false)
                        } else {
                            /// insert user into firebase firestore
                            let name = result?.user.email ?? "no email"
                            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                            self?.firestore.collection("users").document(emailFormatted).setData(["name": "Igor"])
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

/*
 @IBAction func tappedCadastrarButton(_ sender: UIButton) {
     
     let email: String = textFieldEmail.text ?? ""
     let senha: String = textFieldSenha.text ?? ""
     
     let confirmarSenha:String = textFieldConfirmarSenha.text ?? ""
     
     if senha == confirmarSenha {
         self.auth?.createUser(withEmail: email, password: senha, completion: { [weak self] result, error in
             if error != nil{
                 self?.alert?.alertInformation(title: "Heads up", message: "Error registering, check the data and try again")
             } else {
                 
                 let name = result?.user.email ?? "no email"
                 let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                 let userRef = self?.firestore?.collection("usuarios").document(emailFormatted)
                 
                 userRef?.getDocument { snapshot, error in
                     guard let snapshot else { return }
                     if !snapshot.exists {
                         userRef?.setData([
                             "nome": self?.textFieldName.text ?? "user",
                             "email": self?.textFieldEmail.text ?? "no email",
                         ]) { error in
                             if error != nil {
                                 print("Error writing document: (error.localizedDescription)")
                             } else {
                                 print("User data successfully written to Firestore!")
                             }
                         }
                     }
                 }

                 
                 self?.alert?.alertInformation(title: "Success", message: "Successfully registered user", completion: {
                     let homeVC: MainTabBarController? =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? MainTabBarController
                     
                     DispatchQueue.global(qos: .userInitiated).async {
                         // igor-gmail-com
                         let database = Database.database().reference()
                         let data = ["name": name, "email": email]
                         let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                         database.child("users").child(emailFormatted).setValue(data)
                     }
                     
                     self?.navigationController?.pushViewController(homeVC ?? UIViewController(), animated: true)
                 })
             }
         })
     } else {
         self.alert?.alertInformation(title: "Heads up", message: "Divergent Passwords")
     }
 }
 */
