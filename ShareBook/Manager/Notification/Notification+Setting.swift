//
//  Notification+Setting.swift
//  ShareBook
//
//  Created by 권형일 on 9/16/24.
//

import Foundation
import FirebaseFirestore

extension NotificationManager {
    static func loadUserNotificationType(userId: String) async -> [NotificationType] {
        do {
            let document = try await Firestore.firestore()
                .collection("User").document(userId)
                .getDocument()
            
            return try document.data(as: User.self).notificationType
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func editNotificationType(editedData: [String: Any]) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        do {
            try await Firestore.firestore()
                .collection("User").document(userId)
                .updateData(editedData)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
