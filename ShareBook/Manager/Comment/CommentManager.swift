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
                .collection("Posts").document(comment.postId)
                .collection("Post_Comment").addDocument(data: encodedComment)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadUserAllComment(postId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("Posts").document(postId)
                .collection("Post_Comment").order(by: "date", descending: true)
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
    
    static func loadPostCommentCount(postId: String) async -> Int {
        do {
            return try await Firestore.firestore()
                .collection("Posts").document(postId)
                .collection("Post_Comment").getDocuments().documents.count
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}
