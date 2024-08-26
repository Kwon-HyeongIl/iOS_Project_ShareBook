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
    
    func calNumBase26And393(geometryWidth: CGFloat) -> CGFloat {
        return 26 + ((geometryWidth - 393) * (0.6))
    }
}
