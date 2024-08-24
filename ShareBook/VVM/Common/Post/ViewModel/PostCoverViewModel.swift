//
//  PostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import Foundation

@Observable
class PostCoverViewModel {
    var post: Post
    var isLike = false
    var commentCount = 0
    
    init(post: Post) {
        self.post = post
        
        Task {
            await isLike()
            await loadAllPostCommentAndCommentReplyCount()
        }
    }
}
