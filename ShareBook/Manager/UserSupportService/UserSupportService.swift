//
//  UserSupportService.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation
import FirebaseFirestore

class UserSupportService {
    static func feedback(content: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let feedback = Feedback(id: UUID().uuidString, userId: userId, content: content, date: Date())
        
        do {
            let encodedFeedback = try Firestore.Encoder().encode(feedback)
            try await Firestore.firestore()
                .collection("Feedback").document()
                .setData(encodedFeedback)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func reportPost(postId: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let report = Report(id: UUID().uuidString, reportUserId: userId, reportedPostId: postId, date: Date())
        
        do {
            let encodedReport = try Firestore.Encoder().encode(report)
            try await Firestore.firestore()
                .collection("Report").document()
                .setData(encodedReport)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
