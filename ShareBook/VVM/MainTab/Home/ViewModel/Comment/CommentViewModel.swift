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
    var commentReplys: [Comment] = []
    
    var commentText = ""
    
    var currentUser: User?
    
    init(comment: Comment) {
        self.comment = comment
        
        guard let user = AuthManager.shared.currentUser else { return }
        self.currentUser = user
        
        Task {
            await loadAllCommentCommentReplys()
        }
    }
    
    func loadAllCommentCommentReplys() async {
        self.commentReplys = await CommentManager.loadAllCommentCommentReplys(postId: comment.postId, upperCommentId: comment.id)
    }
}
