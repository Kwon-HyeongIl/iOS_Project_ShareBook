//
//  ProfileEditViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import Foundation

@Observable
class ProfileEditViewModel {
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
}
