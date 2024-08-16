//
//  MyPostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

@Observable
class MyPostsViewModel {
    var posts: [Post] = []
    
    init() {
        Task {
            await loadMyAllPost()
        }
    }
    
    func loadMyAllPost() async {
        self.posts = await PostManager.loadMyAllPosts()
    }
}
