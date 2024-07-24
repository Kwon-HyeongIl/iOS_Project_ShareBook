//
//  LoginViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func login() async {
        await AuthManager.shared.login(email: self.email, password: self.password)
    }
}
