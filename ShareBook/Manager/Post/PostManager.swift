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
            try await Firestore.firestore().collection("Post").document(postId).setData(encodedPost)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadAllPosts() async -> [Post] {
        do {
            let documents = try await Firestore.firestore().collection("Post")
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
            let documents = try await Firestore.firestore().collection("Post")
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
    
    static func loadAllUserPosts(userId: String) async -> [Post] {
        do {
            let documents = try await Firestore.firestore().collection("Post")
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
            let documents = try await Firestore.firestore().collection("Post")
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
    
    static func loadSpecificPost(postId: String) async -> Post? {
        do {
            let document = try await Firestore.firestore()
                .collection("Post").document(postId)
                .getDocument()
            
            return try document.data(as: Post.self)
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func deletePost(postId: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        do {
            try await Firestore.firestore()
                .collection("Post").document(postId)
                .delete()
            
            let documentRef = Firestore.firestore()
                .collection("User").document(userId)
                
            let user = try await documentRef.getDocument().data(as: User.self)
            
            // 타이틀 북에 등록한 글을 삭제했을 경우
            if user.titlePostId ?? "" == postId {
                try await documentRef.updateData(["titlePostId": FieldValue.delete()])
                AuthManager.shared.currentUser?.titlePostId = nil
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
