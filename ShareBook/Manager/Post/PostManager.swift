//
//  PostManager.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation
import FirebaseFirestore

class PostManager {
    static func uploadPost(impressivePhrase: String, feelingCaption: String, book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        guard let user = AuthManager.shared.currentUser else { return }
        
        let post = Post(id: UUID().uuidString, userId: userId, impressivePhrase: impressivePhrase, feelingCaption: feelingCaption, like: 0, date: Date(), book: book, user: user)
        
        do {
            let encodedPost = try Firestore.Encoder().encode(post)
            try await Firestore.firestore().collection("Posts").document().setData(encodedPost)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadAllPost() async -> [Post] {
        do {
            let documents = try await Firestore.firestore().collection("Posts")
                .order(by: "date", descending: true).getDocuments().documents
            
            let posts = try documents.compactMap({ document in
                return try document.data(as: Post.self)
            })
            
            return posts
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func loadMyAllPost() async -> [Post] {
        guard let userId = AuthManager.shared.currentUser?.id else { return [] }
        
        do {
            let documents = try await Firestore.firestore().collection("Posts")
                .order(by: "date", descending: true).whereField("userId", isEqualTo: userId)
                .getDocuments().documents
            
            let posts = try documents.compactMap({ document in
                return try document.data(as: Post.self)
            })
            
            return posts
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
