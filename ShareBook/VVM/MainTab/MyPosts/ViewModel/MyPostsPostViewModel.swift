//
//  MyPostsPostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

@Observable
class MyPostsPostViewModel {
    var post: Post
    var isLike = false
    var commentCount = 0
    
    init(post: Post) {
        self.post = post
    }
}
