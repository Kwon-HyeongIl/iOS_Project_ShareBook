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
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
