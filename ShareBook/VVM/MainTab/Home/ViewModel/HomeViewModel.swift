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
    
    func loadSpecificGenrePosts(genre: Genre) async {
        self.posts = await PostManager.loadSpecificGenrePosts(genre: genre)
    }
    
    func calSizemBase70And393(proxyWidth: CGFloat) -> CGFloat {
        return 70 + ((proxyWidth - 393) * (0.15))
    }
    
    func calSizeBase26And393(proxyWidth: CGFloat) -> CGFloat {
        return 26 + ((proxyWidth - 393) * (0.6))
    }
}
