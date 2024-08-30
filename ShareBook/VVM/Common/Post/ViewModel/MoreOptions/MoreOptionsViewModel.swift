//
//  MoreOptionsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/22/24.
//

import Foundation

@Observable
class MoreOptionsViewModel {
    let post: Post
    var isMyPost = false
    
    init(post: Post) {
        self.post = post
        Task {
            await isMyPost(postUserId: post.userId)
        }
    }
    
    private func isMyPost(postUserId: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        self.isMyPost = userId == postUserId ? true : false
    }
    
    func reportPost() async {
        await UserSupportService.reportPost(postId: post.id)
    }
    
    func deletePost() async {
        await PostManager.deletePost(postId: post.id)
    }
}
