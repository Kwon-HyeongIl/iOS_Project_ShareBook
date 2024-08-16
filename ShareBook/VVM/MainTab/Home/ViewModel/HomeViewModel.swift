//
//  PostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation

@Observable
class HomeViewModel {
    var hotPosts: [Post] = []
    var posts: [Post] = []
    
    init() {
        Task {
            await loadHotPosts()
            await loadAllPosts()
        }
    }
    
    func loadHotPosts() async {
        self.hotPosts = await PostManager.loadHotPosts()
    }
    
    func loadAllPosts() async {
        self.posts = await PostManager.loadAllPosts()
    }
}
