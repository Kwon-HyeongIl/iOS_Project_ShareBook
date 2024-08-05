//
//  BookManager+Bookmark.swift
//  ShareBook
//
//  Created by 권형일 on 8/4/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

extension BookManager {
    static func bookmark(book: Book) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let isbn = book.isbn
        
        var bookmarkBook = book
        bookmarkBook.bookmarkDate = Date()
        
        do {
            let encodedData = try Firestore.Encoder().encode(bookmarkBook)
            
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
    
    static func loadAllBookmarkBooks() async -> [Book] {
        guard let userId = AuthManager.shared.currentUser?.id else { return [] }
        
        do {
            let documents = try await Firestore.firestore()
                .collection("Users").document(userId)
                .collection("Users_Bookmark").order(by: "bookmarkDate", descending: true)
                .getDocuments().documents
            
            let books = try documents.compactMap({ document in
                return try document.data(as: Book.self)
            })
            
            return books
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
