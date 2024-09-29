//
//  LoginViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import Foundation

@Observable
class LoginViewModel: NSObject {
    var email = ""
    var password = ""
    
    func login() async -> Bool {
        return await AuthManager.shared.login(email: self.email, password: self.password)
    }
}
