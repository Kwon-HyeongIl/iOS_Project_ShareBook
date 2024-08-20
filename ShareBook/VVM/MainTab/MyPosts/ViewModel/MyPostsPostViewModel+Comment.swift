//
//  MyPostsPostViewModel+Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/20/24.
//

import Foundation

extension MyPostsPostViewModel {
    func loadAllPostCommentAndCommentReplyCount() async {
        self.commentCount = await CommentManager.loadAllPostCommentAndCommentReplyCount(postId: post.id)
    }
}
