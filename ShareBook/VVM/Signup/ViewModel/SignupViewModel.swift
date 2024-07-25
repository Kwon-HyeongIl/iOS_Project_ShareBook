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
}
