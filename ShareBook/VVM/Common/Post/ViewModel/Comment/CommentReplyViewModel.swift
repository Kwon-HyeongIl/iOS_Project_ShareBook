//
//  CommentReplyViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/16/24.
//

import Foundation

@Observable
class CommentReplyViewModel {
    let commentReply: Comment
    
    let commentId: String
    var isMyCommentReply = false
    
    init(commentReply: Comment, commentId: String) {
        self.commentReply = commentReply
        self.commentId = commentId
        
        Task {
            await isMyComment()
        }
    }
    
    private func isMyComment() async {
        if commentReply.commentUserId == AuthManager.shared.currentUser?.id {
            self.isMyCommentReply = true
        }
    }
    
    func deleteCommentReply() async {
        await CommentManager.deleteSpecificCommentReply(postId: commentReply.postId, commentId: commentId, commentReplyId: commentReply.id)
    }
}
