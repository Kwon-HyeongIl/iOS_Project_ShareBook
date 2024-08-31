//
//  ProfileOptionViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import Foundation

@Observable
class ProfileOptionViewModel {
    let user: User?
    
    init() {
        self.user = AuthManager.shared.currentUser
    }
    
    func signout() {
        AuthManager.shared.signout()
    }
}
