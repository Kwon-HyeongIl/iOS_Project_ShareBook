//
//  FollowerViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import Foundation

@Observable
class FollowerViewModel {
    let targetUser: User?
    var users: [User] = []
    
    var isFirstLoad = true
    var isRedacted = true
    
    init(user: User?) {
        self.targetUser = user
        
        Task {
            await loadAllFollowers()
        }
    }
    
    func loadAllFollowers() async {
        self.users = await AuthManager.shared.loadAllFollowers(userId: targetUser?.id ?? "")
    }
}
