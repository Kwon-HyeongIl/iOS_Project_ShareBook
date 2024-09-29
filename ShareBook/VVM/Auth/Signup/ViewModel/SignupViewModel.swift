//
//  SignupViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import Foundation

@Observable
class SignupViewModel {
    var email = ""
    var password = ""
    var username = ""
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, username: username)
        
        email = ""
        password = ""
        username = ""
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
}
