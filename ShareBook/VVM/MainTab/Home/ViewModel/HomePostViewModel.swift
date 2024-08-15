//
//  PostCoverViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation

@Observable
class HomePostViewModel {
    var post: Post
    var isLike = false
    
    init(post: Post) {
        self.post = post
        
        Task {
            await isLike()
        }
    }
    
}
