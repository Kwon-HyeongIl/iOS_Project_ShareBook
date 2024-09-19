//
//  CommentCellViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/19/24.
//

import Foundation

@Observable
class CommentViewModel {
    var comment: Comment
    var commentReplies: [Comment] = []
    
    var commentText = ""
    
    var currentUser: User?
    var isMyComment = false
    
    init(comment: Comment) {
        self.comment = comment
        
        guard let user = AuthManager.shared.currentUser else { return }
        self.currentUser = user
        
        Task {
            await loadAllCommentCommentReplies()
            await isMyComment()
        }
    }
    
    func loadAllCommentCommentReplies() async {
        self.commentReplies = await CommentManager.loadAllCommentCommentReplies(postId: comment.postId, upperCommentId: comment.id)
    }
    
    private func isMyComment() async {
        if comment.commentUserId == AuthManager.shared.currentUser?.id {
            self.isMyComment = true
        }
    }
    
    func deleteComment() async {
        await CommentManager.deleteSpecificComment(postId: comment.postId, commentId: comment.id)
    }
}
