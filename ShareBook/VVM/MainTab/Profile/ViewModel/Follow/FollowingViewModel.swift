//
//  FollowingViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import Foundation

@Observable
class FollowingViewModel {
    let targetUser: User?
    var users: [User] = []
    
    var isFirstLoad = true
    var isRedacted = true
    
    init(user: User?) {
        self.targetUser = user
        
        Task {
            await loadAllFollowings()
        }
    }
    
    func loadAllFollowings() async {
        self.users = await AuthManager.shared.loadAllFollowings(userId: targetUser?.id ?? "")
    }
}
