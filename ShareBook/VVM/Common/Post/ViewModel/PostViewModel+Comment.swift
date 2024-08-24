//
//  PostViewModel+Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import Foundation

extension PostCoverViewModel {
    func loadAllPostCommentAndCommentReplyCount() async {
        self.commentCount = await CommentManager.loadAllPostCommentAndCommentReplyCount(postId: post.id)
    }
}
