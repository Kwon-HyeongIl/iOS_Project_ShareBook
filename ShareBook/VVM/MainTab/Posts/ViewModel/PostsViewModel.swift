//
//  PostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation

@Observable
class PostsViewModel {
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllPost()
        }
    }
    
    func loadAllPost() async {
        self.posts = await PostManager.loadAllPost()
    }
}
