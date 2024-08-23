//
//  MyPostsPostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

@Observable
class LikesPostViewModel {
    var post: Post
    var isLike = false
    var commentCount = 0
    
    init(post: Post) {
        self.post = post
    }
    
    func deletePost() async {
        await PostManager.deletePost(postId: post.id)
    }
}
