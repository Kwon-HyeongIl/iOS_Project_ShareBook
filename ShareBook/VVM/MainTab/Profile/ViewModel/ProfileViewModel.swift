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
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
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
    
    func basicLoading() async {
        await loadAllUserPosts(userId: user?.id ?? "")
        
        // 타이틀 글이 변경되었을 경우
        if let postId = AuthManager.shared.currentUser?.titlePostId {
            let post = await PostManager.loadSpecificPost(postId: postId)
            self.titlePost = post
            
        // 타이틀 글이 삭제 되었을 경우
        } else {
            self.titlePost = nil
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
    
    // 프로필 편집 완료시 실행
    func updateUser() async throws {
        var editedData: [String : Any] = [:]
        
        if let uiImage = self.uiImage {
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .profile) else { return }
            editedData["profileImageUrl"] = imageUrl
        }
        
        editedData["username"] = user?.username ?? ""
        editedData["titleGenre"] = titleGenre.rawValue
        
        if let titlePost {
            editedData["titlePostId"] = titlePost.id
        } else { // 타이틀 글을 취소한 경우
            AuthManager.shared.currentUser?.titlePostId = nil
        }
        
        await ProfileManager.updateUser(editedData: editedData)
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func signOut() {
        AuthManager.shared.signOut()
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
