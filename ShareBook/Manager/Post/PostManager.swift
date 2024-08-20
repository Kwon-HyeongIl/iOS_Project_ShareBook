//
//  PostManager.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation
import FirebaseFirestore

class PostManager {
    static func uploadPost(impressivePhrase: String, feelingCaption: String, genre: Genre, book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        guard let user = AuthManager.shared.currentUser else { return }
        let postId = UUID().uuidString
        
        let post = Post(id: postId, userId: userId, impressivePhrase: impressivePhrase, feelingCaption: feelingCaption, likeCount: 0, date: Date(), book: book, genre: genre, user: user)
        
        do {
            let encodedPost = try Firestore.Encoder().encode(post)
            try await Firestore.firestore().collection("Posts").document(postId).setData(encodedPost)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadAllPosts() async -> [Post] {
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
    
    static func loadHotPosts() async -> [Post] {
        let oneWeekAgo = Date().addingTimeInterval(-7 * 24 * 60 * 60)
        
        do {
            let documents = try await Firestore.firestore().collection("Posts")
                .whereField("date", isGreaterThanOrEqualTo: oneWeekAgo)
                .order(by: "likeCount", descending: true)
                .limit(to: 8)
                .getDocuments().documents
            
            return try documents.compactMap({ document in
                try document.data(as: Post.self)
            })
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func loadAllMyPosts() async -> [Post] {
        guard let userId = AuthManager.shared.currentUser?.id else { return [] }
        
        do {
            let documents = try await Firestore.firestore().collection("Posts")
                .whereField("userId", isEqualTo: userId).order(by: "date", descending: true)
                .getDocuments().documents
            
            return try documents.compactMap({ document in
                try document.data(as: Post.self)
            })
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func loadSpecificGenrePosts(genre: Genre) async -> [Post] {
        do {
            let documents = try await Firestore.firestore().collection("Posts")
                .whereField("genre", isEqualTo: genre.rawValue) // FireStore에 RawValue 값이 저장
                .order(by: "date", descending: true)
                .getDocuments().documents
            
            return try documents.compactMap({ document in
                try document.data(as: Post.self)
            })
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
