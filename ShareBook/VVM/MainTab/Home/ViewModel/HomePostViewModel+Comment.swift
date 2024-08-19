//
//  HomePostViewModel+Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/16/24.
//

import Foundation

extension HomePostViewModel {
    func loadAllPostCommentAndCommentReplyCount() async {
        self.commentCount = await CommentManager.loadAllPostCommentAndCommentReplyCount(postId: post.id)
    }
}
