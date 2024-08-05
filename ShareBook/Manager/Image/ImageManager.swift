//
//  ImageManager.swift
//  ShareBook
//
//  Created by 권형일 on 7/26/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

class ImageManager {
    static func convertImage(item: PhotosPickerItem?) async -> ImageSelection? {
        guard let item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        let image = Image(uiImage: uiImage)
        let imageSelection = ImageSelection(image: image, uiImage: uiImage)
        
        return imageSelection
    }
    
    static func uploadImage(uiImage: UIImage, path: ImagePath) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        let reference = Storage.storage().reference(withPath: "/\(path)/\(fileName)")

        do {
            _ = try await reference.putDataAsync(imageData)
            let url = try await reference.downloadURL()
            
            return url.absoluteString
            
        } catch {
            print("image upload failed \(error.localizedDescription)")
            
            return nil
        }
    }
}

struct ImageSelection {
    let image: Image
    let uiImage: UIImage
}

enum ImagePath {
    case post
    case porfile
}
