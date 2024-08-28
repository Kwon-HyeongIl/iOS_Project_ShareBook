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
    
    static func loadAllPostCommentAndCommentReplyCount(postId: String) async -> Int {
        do {
            let commentDocuments = try await Firestore.firestore()
                .collection("Post").document(postId)
                .collection("Post_Comment").getDocuments().documents
            
            let comments = try commentDocuments.compactMap { document in
                try document.data(as: Comment.self)
            }
            
            var totalCommentCount = comments.count
            
            for comment in comments {
                totalCommentCount += try await Firestore.firestore()
                    .collection("Post").document(postId)
                    .collection("Post_Comment").document(comment.id)
                    .collection("Comment_Reply").getDocuments().documents.count
            }
            
            return totalCommentCount
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}
