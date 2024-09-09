//
//  LikePostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import Foundation

@Observable
class LikePostViewModel {
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllLikePosts()
        }
    }
    
    func loadAllLikePosts() async {
        self.posts = await PostManager.loadAllLikePosts()
    }
    
    func postSpacing(proxyWidth: CGFloat) -> CGFloat {
        return 20 + ((proxyWidth - 393) * (0.45))
    }
}
