//
//  FollowViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import Foundation

@Observable
class FollowViewModel {
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
}
