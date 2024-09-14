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
        var bookTitleMax8 = String(post.book.title.prefix(8))
        if bookTitleMax8.count == 8 {
            bookTitleMax8.append("...")
        }
        
        // 💌 FCM
        let postUserDeviceToken = await AuthManager.shared.getSpecificUserDeviceToken(userId: post.userId)
        await FCMManager.shared.sendFCMNotification(deviceToken: postUserDeviceToken, type: .like, data: post.id, title: "좋아요", body: "\(AuthManager.shared.currentUser?.username ?? "")님이 \"\(bookTitleMax8)\" 글에 좋아요를 눌렀습니다!")
        
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let userLikePost = UserLikePost(id: UUID().uuidString, postId: post.id, date: Date())
        
        guard let encodedUserLikePost = try? Firestore.Encoder().encode(userLikePost) else { return }
        
        async let _ = Firestore.firestore()
            .collection("User").document(userId)
            .collection("User_Like").document(post.id)
            .setData(encodedUserLikePost)
        
        async let _ = Firestore.firestore()
            .collection("Post").document(post.id)
            .collection("Post_Liked").document(userId)
            .setData([:])
        
        async let _ = Firestore.firestore()
            .collection("Post").document(post.id)
            .updateData(["likeCount": post.likeCount + 1])
    }
    
    static func unLike(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        async let _ = Firestore.firestore()
            .collection("User").document(userId)
            .collection("User_Like").document(post.id)
            .delete()
        
        async let _ = Firestore.firestore()
            .collection("Post").document(post.id)
            .collection("Post_Liked").document(userId)
            .delete()
        
        async let _ = Firestore.firestore()
            .collection("Post").document(post.id)
            .updateData(["likeCount": post.likeCount - 1])
    }
    
    static func isLike(post: Post) async -> Bool {
        guard let userId = AuthManager.shared.currentUser?.id else { return false }
        
        do {
            return try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("User_Like").document(post.id)
                .getDocument().exists
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func loadAllLikePosts() async -> [Post] {
        guard let userId = AuthManager.shared.currentUser?.id else { return [] }
        
        do {
            let documents = try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("User_Like").order(by: "date", descending: true)
                .getDocuments().documents
            
            let postIds = try documents.compactMap({ document in
                try document.data(as: UserLikePost.self).postId
            })
            
            let postRef = Firestore.firestore().collection("Post")
            var posts: [Post] = []
            
            for postId in postIds {
                let document = try await postRef.document(postId).getDocument()
                
                posts.append(try document.data(as: Post.self))
            }
            
            return posts
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
