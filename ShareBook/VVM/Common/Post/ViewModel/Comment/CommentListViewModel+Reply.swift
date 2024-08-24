//
//  CommentListViewModel+Reply.swift
//  ShareBook
//
//  Created by 권형일 on 8/20/24.
//

import Foundation

extension CommentListViewModel {
    func uploadCommentReply(upperCommentId: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let commentReply = Comment(id: UUID().uuidString, commentText: commentText, postId: post.id, postUserId: post.userId, commentUserId: userId, commentUser: currentUser, date: Date())
        
        await CommentManager.uploadCommentReply(commentReply: commentReply, upperCommentId: upperCommentId)
    }
}
