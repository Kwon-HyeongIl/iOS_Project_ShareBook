//
//  PostCoverViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation

@Observable
class PostViewModel {
    var post: Post
    var isLike = false
    
    init(post: Post) {
        self.post = post
    }
}
