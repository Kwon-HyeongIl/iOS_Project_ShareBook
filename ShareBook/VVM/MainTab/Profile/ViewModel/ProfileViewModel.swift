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
    var user: User?
    var posts: [Post] = []
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    init() {
        self.user = AuthManager.shared.currentUser
        Task {
            await loadAllPosts()
        }
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func loadAllPosts() async {
        self.posts = await PostManager.loadAllPosts()
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
}
