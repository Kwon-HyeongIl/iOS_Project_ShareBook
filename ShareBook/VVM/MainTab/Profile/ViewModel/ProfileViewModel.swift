//
//  ProfileViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/26/24.
//

import SwiftUI
import PhotosUI

@Observable
class ProfileViewModel: Hashable, Equatable {
    var user: User?
    var posts: [Post] = []
    
    var followingCount = 0
    var followerCount = 0
    
    var isMyProfile: Bool?
    var isFollow: Bool?
    
    var titleGenre: Genre?
    var titleBookImageUrl = ""
    var titleBookImpressivePhrase: String?
    var titlePostId: String?
    
    init(user: User?) {
        self.user = user
        let currentUser = AuthManager.shared.currentUser
        
        self.titleGenre = user?.titleGenre
        self.titleBookImageUrl = user?.titleBookImageUrl ?? ""
        self.titleBookImpressivePhrase = user?.titleBookImpressivePhrase
        self.titlePostId = user?.titlePostId
        
        Task {
            await loadAllUserPosts(userId: user?.id ?? "")
            await loadFollowingCount(userId: user?.id ?? "")
            await loadFollowerCount(userId: user?.id ?? "")
            
            if user?.id ?? "" != currentUser?.id ?? "" {
                self.isMyProfile = false
                await isFollow(userId: user?.id ?? "")
            } else {
                self.isMyProfile = true
            }
        }
    }
    
    func basicLoad() async {
        let user = AuthManager.shared.currentUser
        
//        self.titleGenre = user?.titleGenre
//        self.titleBookImageUrl = user?.titleBookImageUrl ?? ""
//        self.titleBookImpressivePhrase = user?.titleBookImpressivePhrase
//        self.titlePostId = user?.titlePostId
        
        await loadAllUserPosts(userId: user?.id ?? "")
    }
    
    func loadAllUserPosts(userId: String) async {
        self.posts = await PostManager.loadAllUserPosts(userId: userId)
    }
    
    
    func follow() async {
        await AuthManager.shared.follow(followUserId: user?.id ?? "")
        
        await loadFollowingCount(userId: user?.id ?? "")
        await loadFollowerCount(userId: user?.id ?? "")
        isFollow = true
    }
    
    func unFollow() async {
        await AuthManager.shared.unFollow(unFollowUserId: user?.id ?? "")
        
        await loadFollowingCount(userId: user?.id ?? "")
        await loadFollowerCount(userId: user?.id ?? "")
        isFollow = false
    }
    
    func loadFollowingCount(userId: String) async {
        self.followingCount = await AuthManager.shared.loadFollowingCount(userId: userId)
    }
    
    func loadFollowerCount(userId: String) async {
        self.followerCount = await AuthManager.shared.loadFollowerCount(userId: userId)
    }
    
    func isFollow(userId: String) async {
        self.isFollow = await AuthManager.shared.isFollow(userId: userId)
    }
    
    
    
    
    func calSizemBase1And393(proxyWidth: CGFloat) -> CGFloat {
        return 1 + ((proxyWidth - 393) * (0.002))
    }
    
    func calSizeBase4And393(proxyWidth: CGFloat) -> CGFloat {
        return 5 + ((proxyWidth - 393))
    }
    
    static func == (lhs: ProfileViewModel, rhs: ProfileViewModel) -> Bool {
        return lhs.user == rhs.user &&
        lhs.posts == rhs.posts &&
        lhs.followingCount == rhs.followingCount &&
        lhs.followerCount == rhs.followerCount &&
        lhs.isMyProfile == rhs.isMyProfile &&
        lhs.isFollow == rhs.isFollow
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
        hasher.combine(posts)
        hasher.combine(followingCount)
        hasher.combine(followerCount)
        hasher.combine(isMyProfile)
        hasher.combine(isFollow)
    }
}
