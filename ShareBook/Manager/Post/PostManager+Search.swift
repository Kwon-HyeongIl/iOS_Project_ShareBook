//
//  PostManager+Search.swift
//  ShareBook
//
//  Created by 권형일 on 9/7/24.
//

import Foundation
import FirebaseFirestore

extension PostManager {
    static func searchPostByBookName(searchText: String) async -> [Post] {
        do {
            let postDocuments = try await Firestore.firestore()
                .collection("Post").whereField("bookTitleKeywords", arrayContains: searchText)
                .getDocuments().documents
            
            let posts = try postDocuments.compactMap({ document in
                return try document.data(as: Post.self)
            })
            
            return posts
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
