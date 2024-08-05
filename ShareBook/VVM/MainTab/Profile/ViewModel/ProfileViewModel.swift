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
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    init() {
        self.user = AuthManager.shared.currentUser
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func signout() {
        AuthManager.shared.signout()
    }
}
