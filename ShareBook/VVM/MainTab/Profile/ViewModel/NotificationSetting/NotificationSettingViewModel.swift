//
//  NotificationSettingViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/15/24.
//

import Foundation

@Observable
class NotificationSettingViewModel {
    var commentNotification = true
    var likeNotification = true
    var followNotification = true
    
    init() {
        Task {
            await loadMyNotificationType()
        }
    }
    
    private func loadMyNotificationType() async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        let notificationType = await NotificationManager.loadUserNotificationType(userId: userId)
        
        self.commentNotification = notificationType.contains(.comment) ? true : false
        self.likeNotification = notificationType.contains(.like) ? true : false
        self.followNotification = notificationType.contains(.follow) ? true : false
    }
    
    func editNotificationType() async {
        var editedData: [String : Any] = [:]
        
        var tempNotificationType: [String] = []
        
        if commentNotification {
            tempNotificationType.append("comment")
        }
        
        if likeNotification {
            tempNotificationType.append("like")
        }
        
        if followNotification {
            tempNotificationType.append("follow")
        }
        
        editedData["notificationType"] = tempNotificationType
        
        await NotificationManager.editNotificationType(editedData: editedData)
    }
}
