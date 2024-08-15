//
//  CommentViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

@Observable
class CommentViewModel {
    var post: Post
    
    init(post: Post) {
        self.post = post
    }
}
