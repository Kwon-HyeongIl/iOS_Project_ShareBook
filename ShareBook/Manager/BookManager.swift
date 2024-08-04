//
//  BookManager.swift
//  ShareBook
//
//  Created by 권형일 on 7/29/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class BookManager {
    static func bookmark(book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        let isbn = book.isbn
        
        do {
            let encodedData = try Firestore.Encoder().encode(book)
            
            try await Firestore.firestore()
                .collection("Users").document(userId)
                .collection("Users_Bookmark").document(isbn).setData(encodedData)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func unbookmark(book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        do {
            try await Firestore.firestore()
                .collection("Users").document(userId)
                .collection("Users_Bookmark").document(book.isbn).delete()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func isBookmark(isbn: String) async -> Bool {
        guard let userId = AuthManager.shared.currentUser?.id else { return false}
        
        do {
            return try await !Firestore.firestore()
                .collection("Users").document(userId)
                .collection("Users_Bookmark").whereField("isbn", isEqualTo: isbn).getDocuments().isEmpty
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
