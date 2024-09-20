//
//  CommentManager+Reply.swift
//  ShareBook
//
//  Created by 권형일 on 8/19/24.
//

import Foundation
import FirebaseFirestore

extension CommentManager {
    static func uploadCommentReply(commentReply: Comment, upperCommentId: String) async {
        guard let encodedCommentReply = try? Firestore.Encoder().encode(commentReply) else { return }
        
        // 💌 FCM
        let postUserDeviceToken = await AuthManager.shared.getSpecificUserDeviceToken(userId: commentReply.postUserId)
        let notification = Notification(id: UUID().uuidString, type: .comment, data: commentReply.postId, title: "새 댓글", body: commentReply.commentText, date: Date())
        await FCMManager.shared.sendFCMNotification(deviceToken: postUserDeviceToken, userId: commentReply.postUserId, notification: notification)
        
        do {
            try await Firestore.firestore()
                .collection("Post").document(commentReply.postId)
                .collection("Post_Comment").document(upperCommentId)
                .collection("Comment_Reply").document(commentReply.id)
                .setData(encodedCommentReply)
            
            try await Firestore.firestore()
                .collection("Post").document(commentReply.postId)
                .collection("Post_Comment").document(upperCommentId)
                .updateData(["commentReplyCount": FieldValue.increment(Int64(1))])
            
            try await Firestore.firestore()
                .collection("Post").document(commentReply.postId)
                .updateData(["commentCount": FieldValue.increment(Int64(1))])
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadAllCommentCommentReplies(postId: String, upperCommentId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").document(upperCommentId)
                .collection("Comment_Reply").order(by: "date")
                .getDocuments().documents
            
            return try documents.compactMap { document in
                try document.data(as: Comment.self)
            }
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func deleteSpecificCommentReply(postId: String, commentId: String, commentReplyId: String) async {
        do {
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").document(commentId)
                .collection("Comment_Reply").document(commentReplyId).delete()
            
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").document(commentId)
                .updateData(["commentReplyCount": FieldValue.increment(Int64(-1))])
            
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .updateData(["commentCount": FieldValue.increment(Int64(-1))])
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
