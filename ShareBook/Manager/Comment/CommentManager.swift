//
//  CommentManager.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation
import FirebaseFirestore

class CommentManager {
    static func uploadComment(comment: Comment) async {
        guard let encodedComment = try? Firestore.Encoder().encode(comment) else { return }
        
        // 💌 FCM
        let postUserDeviceToken = await AuthManager.shared.getSpecificUserDeviceToken(userId: comment.postUserId)
        let notification = Notification(id: UUID().uuidString, type: .comment, data: comment.postId, title: "새 댓글", body: comment.commentText, date: Date())
        await FCMManager.shared.sendFCMNotification(deviceToken: postUserDeviceToken, userId: comment.postUserId, notification: notification)
        
        do {
            try await Firestore.firestore()
                .collection("Post").document(comment.postId)
                .collection("Post_Comment").document(comment.id)
                .setData(encodedComment)
            
            try await Firestore.firestore()
                .collection("Post").document(comment.postId)
                .updateData(["commentCount": FieldValue.increment(Int64(1))])
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadUserAllComment(postId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").order(by: "date")
                .getDocuments().documents
            
            let comments = try documents.compactMap { document in
                try document.data(as: Comment.self)
            }
            
            return comments
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func loadAllPostCommentCount(postId: String) async -> Int {
        do {
            let post = try await Firestore.firestore()
                .collection("Post").document(postId)
                .getDocument().data(as: Post.self)
            
            return post.commentCount
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    static func deleteSpecificComment(postId: String, commentId: String) async {
        do {
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").document(commentId)
                .delete()
            
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .updateData(["commentCount": FieldValue.increment(Int64(-1))])
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
