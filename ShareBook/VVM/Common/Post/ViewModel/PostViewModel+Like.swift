//
//  PostViewModel+Like.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import Foundation

extension PostCoverViewModel {
    func isLike() async {
        self.isLike = await PostManager.isLike(post: post)
    }
    
    func like() async {
        await PostManager.like(post: post)
        
        self.isLike = true
        self.post.likeCount += 1
    }
    
    func unlike() async {
        await PostManager.unlike(post: post)
        
        self.isLike = false
        self.post.likeCount -= 1
    }
}