//
//  ProfileViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/26/24.
//

import SwiftUI
import PhotosUI

@Observable
class ProfileViewModel {
    let user: User?
    var posts: [Post] = []
    
    var followingCount = 0
    var followerCount = 0
    
    var isMyProfile: Bool?
    var isFollow: Bool?
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    init(user: User?) {
        self.user = user
        let currentUser = AuthManager.shared.currentUser
        
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
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
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
}
