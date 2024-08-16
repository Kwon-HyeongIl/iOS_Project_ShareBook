//
//  PostManager+Like.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation
import FirebaseFirestore

extension PostManager {
    static func like(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        async let _ = Firestore.firestore()
            .collection("Users").document(userId)
            .collection("User_Like").document(post.id)
            .setData([:])
        
        async let _ = Firestore.firestore()
            .collection("Posts").document(post.id)
            .collection("Post_Liked").document(userId)
            .setData([:])
        
        async let _ = Firestore.firestore()
            .collection("Posts").document(post.id)
            .updateData(["likeCount": post.likeCount + 1])
    }
    
    static func unlike(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        async let _ = Firestore.firestore()
            .collection("Users").document(userId)
            .collection("User_Like").document(post.id)
            .delete()
        
        async let _ = Firestore.firestore()
            .collection("Posts").document(post.id)
            .collection("Post_Liked").document(userId)
            .delete()
        
        async let _ = Firestore.firestore()
            .collection("Posts").document(post.id)
            .updateData(["likeCount": post.likeCount - 1])
    }
    
    static func isLike(post: Post) async -> Bool {
        guard let userId = AuthManager.shared.currentUser?.id else { return false }
        
        do {
            return try await Firestore.firestore()
                .collection("Users").document(userId)
                .collection("User_Like").document(post.id)
                .getDocument().exists
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
