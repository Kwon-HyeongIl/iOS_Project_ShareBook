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
            await loadAllMyPosts()
        }
    }
    
    func loadAllMyPosts() async {
        self.posts = await PostManager.loadAllMyPosts()
    }
    
    func loadSpecificGenrePosts(genre: Genre) async {
        self.posts = await PostManager.loadSpecificGenrePosts(genre: genre)
    }
}
