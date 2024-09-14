//
//  NotificationManager.swift
//  ShareBook
//
//  Created by 권형일 on 9/14/24.
//

import Foundation
import FirebaseFirestore

class NotificationManager {
    static func saveNotification(userId: String, nofitication: Notification) async {
        do {
            let encodedNotification = try Firestore.Encoder().encode(nofitication)
            
            try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("Notification").document(nofitication.id)
                .setData(encodedNotification)
            
            await notificationBadgeOn(userId: userId)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadAllMyNotifications() async -> [Notification] {
        guard let userId = AuthManager.shared.currentUser?.id else { return [] }
        
        do {
            let notificationDocuments = try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("Notification").order(by: "date", descending: true)
                .getDocuments().documents
            
            return try notificationDocuments.compactMap({ document in
                try document.data(as: Notification.self)
            })
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    

}
