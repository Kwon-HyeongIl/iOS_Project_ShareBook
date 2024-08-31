//
//  ProfileManager.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import Foundation
import FirebaseFirestore

class ProfileManager {
    static func updateUser(editedData: [String : Any]) async {
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
