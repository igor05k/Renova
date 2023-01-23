//
//  RegisterViewModel.swift
//  Renova
//
//  Created by Igor Fernandes on 22/01/23.
//

import Foundation

protocol RegisterViewModelProtocol {
    func numberOfRowsInSection(_ section: Int) -> Int
    func dequeueForm(at index: Int) -> Forms
    mutating func configForms()
}

struct RegisterViewModel: RegisterViewModelProtocol {
    private var forms: [Forms] = [Forms]()
    
    func dequeueForm(at index: Int) -> Forms { forms[index] }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return forms.count
        default:
            return 1
        }
    }
    
    mutating func configForms() {
        let nome = Forms(formName: "Nome", formPlaceholder: "Digite seu nome...")
        let email = Forms(formName: "Email", formPlaceholder: "exemplo: meuemail@email.com")
        let password = Forms(formName: "Senha", formPlaceholder: "Digite sua senha...")
        let passwordConfirmation = Forms(formName: "Confirmação de senha", formPlaceholder: "Confirme sua senha...")

        forms.append(contentsOf: [nome, email, password, passwordConfirmation])
    }
}
