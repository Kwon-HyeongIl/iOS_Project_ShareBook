//
//  PostsViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI
import FirebaseFirestore

@Observable
class HomeViewModel {
    var hotPosts: [Post] = []
    var posts: [Post] = []
    
    var isNotificationBadge = false
    var isHotRedacted = true
    var isGenreRedacted = true
    var isFirst = true
    var isAddPost = false
    
    var isFetching = false
    var lastDocumentSnapshot: DocumentSnapshot?
    var selectedGenre = Genre.all
    
    @ObservationIgnored let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    init() {
        self.isNotificationBadge = AuthManager.shared.currentUser?.isNotificationBadge ?? false
        
        Task {
            await loadHotPosts()
            await loadAllPostsByPagination()
        }
    }
    
    func loadHotPosts() async {
        self.hotPosts = await PostManager.loadHotPosts()
    }
    
    func loadAllPostsByPagination() async {
        if isFetching { return }
        isFetching = true
        
        let (posts, lastSnapshot) = await PostManager.loadAllPostsByPagination(lastDocument: lastDocumentSnapshot)
        self.lastDocumentSnapshot = lastSnapshot
        
        DispatchQueue.main.async {
            self.posts.append(contentsOf: posts)
            self.isFetching = false
        }
    }
    
    func loadSpecificGenrePostsByPagination(genre: Genre) async {
        if isFetching { return }
        isFetching = true
        
        let (posts, lastSnapshot) = await PostManager.loadSpecificGenrePostsByPagination(genre: genre, lastDocument: lastDocumentSnapshot)
        self.lastDocumentSnapshot = lastSnapshot
        
        DispatchQueue.main.async {
            self.posts.append(contentsOf: posts)
            self.isFetching = false
        }
    }
    
    func notificationBadgeOff() async {
        await NotificationManager.notificationBadgeOff()
        
        AuthManager.shared.currentUser?.isNotificationBadge = false
    }
    
    func resizePost(proxyWidth: CGFloat) -> CGFloat {
        return 17 + ((proxyWidth - 393) * (0.4))
    }
}
