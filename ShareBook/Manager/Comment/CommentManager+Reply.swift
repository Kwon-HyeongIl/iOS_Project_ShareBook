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
        
        do {
            try await Firestore.firestore()
                .collection("Post").document(commentReply.postId)
                .collection("Post_Comment").document(upperCommentId)
                .collection("Comment_Reply").addDocument(data: encodedCommentReply)
            
            try await Firestore.firestore()
                .collection("Post").document(commentReply.postId)
                .collection("Post_Comment").document(upperCommentId)
                .updateData(["commentReplyCount": FieldValue.increment(Int64(1))])
            
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
}
