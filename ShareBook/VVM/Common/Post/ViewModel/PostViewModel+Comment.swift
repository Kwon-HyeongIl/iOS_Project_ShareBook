//
//  PostViewModel+Comment.swift
//  ShareBook
//
//  Created by 권형일 on 9/21/24.
//

import Foundation

extension PostViewModel {
    func loadAllPostCommentCount() async {
        self.post.commentCount = await CommentManager.loadAllPostCommentCount(postId: post.id)
    }
}
