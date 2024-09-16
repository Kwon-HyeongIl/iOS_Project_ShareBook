//
//  PostViewModel+Like.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import Foundation

extension PostViewModel {
    func isLike() async {
        self.isLike = await PostManager.isLike(post: post)
    }
    
    func like() async {
        self.isLike = true
        self.post.likeCount += 1
        
        await PostManager.like(post: post)
    }
    
    func unLike() async {
        self.isLike = false
        self.post.likeCount -= 1
        
        await PostManager.unLike(post: post)
    }
}
