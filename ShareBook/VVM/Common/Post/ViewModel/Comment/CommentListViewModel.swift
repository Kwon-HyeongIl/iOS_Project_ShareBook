//
//  CommentViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

@Observable
class CommentListViewModel {
    var comments: [Comment] = []
    
    var commentText = ""
    var post: Post
    var currentUser: User?
    
    init(post: Post) {
        self.post = post
        
        guard let user = AuthManager.shared.currentUser else { return }
        self.currentUser = user
        
        Task {
            await loadAllUserComment()
        }
    }
    
    func loadAllUserComment() async {
        self.comments = await CommentManager.loadUserAllComment(postId: post.id)
    }
    
    func uploadComment() async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let comment = Comment(id: UUID().uuidString, commentText: commentText, postId: post.id, postUserId: post.userId, commentUserId: userId, commentUser: currentUser, commentReplyCount: 0, date: Date())
        
        await CommentManager.uploadComment(comment: comment)
    }
}
