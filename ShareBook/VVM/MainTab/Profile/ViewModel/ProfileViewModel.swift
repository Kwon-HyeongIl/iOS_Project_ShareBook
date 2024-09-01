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
    
    var userName = ""
    var titleGenre: Genre = .all
    var titlePost: Post?
    
    var profileImage: Image?
    var selectedItem: PhotosPickerItem?
    var uiImage: UIImage?
    
    init(user: User?) {
        guard let _ = user else { return }
        self.user = user
        let currentUser = AuthManager.shared.currentUser
        
        Task {
            if user?.id ?? "" == currentUser?.id ?? "" {
                self.isMyProfile = true
            } else {
                self.isMyProfile = false
                await isFollow(userId: user?.id ?? "")
            }
            
            await loadAllUserPosts(userId: user?.id ?? "")
            await loadFollowingCount(userId: user?.id ?? "")
            await loadFollowerCount(userId: user?.id ?? "")
            
            self.userName = user?.username ?? ""
            
            if let titleGenre = user?.titleGenre {
                self.titleGenre = titleGenre
            }

            if let postId = user?.titlePostId {
                let post = await PostManager.loadSpecificPost(postId: postId)
                self.titlePost = post
            }
        }
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
    
    func updateUser() async throws {
        var editedData: [String : Any] = [:]
        
        if let uiImage = self.uiImage {
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .profile) else { return }
            editedData["profileImageUrl"] = imageUrl
        }
        
        editedData["username"] = user?.username ?? ""
        editedData["titleGenre"] = titleGenre.rawValue
        editedData["titlePostId"] = titlePost?.id ?? ""
        
        await ProfileManager.updateUser(editedData: editedData)
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func signout() {
        AuthManager.shared.signout()
    }
    
    func calSizemBase1And393(proxyWidth: CGFloat) -> CGFloat {
        return 1 + ((proxyWidth - 393) * (0.002))
    }
    
    func calSizeBase4And393(proxyWidth: CGFloat) -> CGFloat {
        return 5 + ((proxyWidth - 393))
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(user?.id)
    }
    
    static func == (lhs: ProfileViewModel, rhs: ProfileViewModel) -> Bool {
        return lhs.user?.id == rhs.user?.id
    }
}
