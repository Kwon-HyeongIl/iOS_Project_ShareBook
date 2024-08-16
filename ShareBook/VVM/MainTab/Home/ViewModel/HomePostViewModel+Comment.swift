//
//  HomePostViewModel+Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/16/24.
//

import Foundation

extension HomePostViewModel {
    func loadPostCommentCount() async {
        self.commentCount = await CommentManager.loadPostCommentCount(postId: post.id)
    }
}
