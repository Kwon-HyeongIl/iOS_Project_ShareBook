//
//  PostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI

@Observable
class HomeViewModel {
    var hotPosts: [Post] = []
    var posts: [Post] = []
    
    var isNotificationBadge = false
    
    var isHotRedacted = true
    var isGenreRedacted = true
    var isFirst = true
    
    var isAddPost = false
    
    @ObservationIgnored let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    init() {
        self.isNotificationBadge = AuthManager.shared.currentUser?.isNotificationBadge ?? false
        
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
    
    func notificationBadgeOff() async {
        await NotificationManager.notificationBadgeOff()
        
        AuthManager.shared.currentUser?.isNotificationBadge = false
    }
    
    func resizePost(proxyWidth: CGFloat) -> CGFloat {
        return 17 + ((proxyWidth - 393) * (0.4))
    }
}
