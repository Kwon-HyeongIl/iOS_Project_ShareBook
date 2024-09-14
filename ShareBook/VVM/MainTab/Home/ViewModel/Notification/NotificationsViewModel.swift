//
//  NotificationsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/14/24.
//

import Foundation

@Observable
class NotificationsViewModel {
    var notifications: [Notification] = []
    
    init() {
        Task {
            await self.loadAllMyNotifications()
        }
    }
    
    func loadAllMyNotifications() async {
        self.notifications = await NotificationManager.loadAllMyNotifications()
    }
    
    func loadSpecificPost(postId: String) async -> Post? {
        await PostManager.loadSpecificPost(postId: postId)
    }
}
