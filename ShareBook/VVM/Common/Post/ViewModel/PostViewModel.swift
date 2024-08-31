//
//  PostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import Foundation

@Observable
class PostViewModel: Hashable, Equatable {
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
    
    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        return lhs.post.id == rhs.post.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(post.id)
    }
}
