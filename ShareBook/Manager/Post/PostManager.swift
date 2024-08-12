//
//  PostManager.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import Foundation
import FirebaseFirestore

class PostManager {
    static func uploadPost(impressivePhrase: String, feelingCaption: String, book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let post = Post(id: UUID().uuidString, userId: userId, impressivePhrase: impressivePhrase, feelingCaption: feelingCaption, like: 0, date: Date(), book: book)
        
        do {
            let encodedPost = try Firestore.Encoder().encode(post)
            try await Firestore.firestore().collection("Posts").document().setData(encodedPost)
        } catch {
            print(error.localizedDescription)
        }
    }
}
