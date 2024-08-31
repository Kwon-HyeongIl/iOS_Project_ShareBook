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
    let user: User?
    var posts: [Post] = []
    
    var editUsername = ""
    var editGenre = Genre.all
    var editTitleBook: Book?
    var editTitleBookImpressivePhrase = ""
    var editTitlePostId = ""
    var isImageChange = false
    
    var followingCount = 0
    var followerCount = 0
    
    var isMyProfile: Bool?
    var isFollow: Bool?
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    init(user: User?) {
        self.user = user
        
        Task {
            await basicLoad()
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
    
    func updateUser() async {
        var editedData: [String : Any] = [:]
        
        if isImageChange {
            if let uiImage {
                guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .profile) else { return }
                editedData["profileImageUrl"] = imageUrl
            }
        }
        
        editedData["username"] = editUsername
        editedData["titleGenre"] = editGenre
        editedData["titleBook"] = editTitleBook
        editedData["titleBookImpressivePhrase"] = editTitleBookImpressivePhrase
        editedData["titlePostId"] = editTitlePostId
        
        await ProfileManager.updateUser(editedData: editedData)
    }
    
    func basicLoad() async {
        let currentUser = AuthManager.shared.currentUser
        
        self.editUsername = user?.username ?? ""
        self.editGenre = user?.titleGenre ?? .mystery
        self.editTitleBook = user?.titleBook
        self.editTitleBookImpressivePhrase = user?.titleBookImpressivePhrase ?? ""
        self.editTitlePostId = user?.titlePostId ?? ""
        self.selectedItem = nil
        self.profileImage = nil
        self.uiImage = nil
        
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
    
    
    
    func signout() {
        AuthManager.shared.signout()
    }
    
    static func == (lhs: ProfileViewModel, rhs: ProfileViewModel) -> Bool {
        return lhs.user == rhs.user &&
        lhs.posts == rhs.posts &&
        lhs.followingCount == rhs.followingCount &&
        lhs.followerCount == rhs.followerCount &&
        lhs.isMyProfile == rhs.isMyProfile &&
        lhs.isFollow == rhs.isFollow &&
        lhs.selectedItem == rhs.selectedItem &&
        lhs.profileImage == rhs.profileImage &&
        lhs.uiImage == rhs.uiImage
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
        hasher.combine(posts)
        hasher.combine(followingCount)
        hasher.combine(followerCount)
        hasher.combine(isMyProfile)
        hasher.combine(isFollow)
        hasher.combine(selectedItem)
//        hasher.combine(profileImage)
        hasher.combine(uiImage)
    }
}
