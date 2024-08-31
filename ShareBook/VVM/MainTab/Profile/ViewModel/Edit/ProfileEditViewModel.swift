//
//  ProfileEditViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import SwiftUI
import PhotosUI

@Observable
class ProfileEditViewModel: Hashable, Equatable {
    let user: User?
    var posts: [Post] = []
    
    var isImageChanged = false
    var profileImageUrl: String?
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    var username = ""
    var titleGenre: Genre = .mystery
    
    var titleBookImageUrl: String?
    var titleBookImpressivePhrase: String?
    var titlePostId: String?
    
    init() {
        self.user = AuthManager.shared.currentUser
        
        Task {
            await loadAllUserPosts(userId: user?.id ?? "")
        }
        
        self.profileImageUrl = user?.profileImageUrl
        self.username = user?.username ?? ""
        if let titleGenre = user?.titleGenre {
            self.titleGenre = titleGenre
        }
        
        if let titleBookImageUrl = user?.titleBookImageUrl, let titleBookImpressivePhrase = user?.titleBookImpressivePhrase, let titlePostId = user?.titlePostId {
            self.titleBookImageUrl = titleBookImageUrl
            self.titleBookImpressivePhrase = titleBookImpressivePhrase
            self.titlePostId = titlePostId
        }
    }
    
    func loadAllUserPosts(userId: String) async {
        self.posts = await PostManager.loadAllUserPosts(userId: userId)
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func calSizemBase1And393(proxyWidth: CGFloat) -> CGFloat {
        return 1 + ((proxyWidth - 393) * (0.002))
    }
    
    func calSizeBase4And393(proxyWidth: CGFloat) -> CGFloat {
        return 5 + ((proxyWidth - 393))
    }
    
    func updateUser() async throws {
        var editedData: [String : Any] = [:]
        
        if isImageChanged {
            if let uiImage = self.uiImage {
                guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .profile) else { return }
                editedData["profileImageUrl"] = imageUrl
                
                isImageChanged = false
            }
        }
        
        editedData["username"] = username
        editedData["titleGenre"] = titleGenre.rawValue
        editedData["titleBookImageUrl"] = titleBookImageUrl
        editedData["titleBookImpressivePhrase"] = titleBookImpressivePhrase
        editedData["titlePostId"] = titlePostId
        
        await ProfileManager.updateUser(editedData: editedData)
    }
    
    static func == (lhs: ProfileEditViewModel, rhs: ProfileEditViewModel) -> Bool {
        return lhs.user?.id == rhs.user?.id &&
        lhs.username == rhs.username &&
        lhs.profileImageUrl == rhs.profileImageUrl &&
        lhs.titleGenre == rhs.titleGenre &&
        lhs.titleBookImageUrl == rhs.titleBookImageUrl &&
        lhs.titleBookImpressivePhrase == rhs.titleBookImpressivePhrase &&
        lhs.titlePostId == rhs.titlePostId
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(user?.id)
            hasher.combine(username)
            hasher.combine(profileImageUrl)
            hasher.combine(titleGenre)
            hasher.combine(titleBookImageUrl)
            hasher.combine(titleBookImpressivePhrase)
            hasher.combine(titlePostId)
        }
}
