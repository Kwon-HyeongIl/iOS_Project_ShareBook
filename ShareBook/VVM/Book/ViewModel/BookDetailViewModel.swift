//
//  BookDetailViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

@Observable
class BookDetailViewModel {
    var book: Book
    var isBookmark = false
    
    init(book: Book) {
        self.book = book
        
        Task {
            await isBookmark(isbn: book.isbn)
        }
    }
    
    func bookmark(book: Book) async {
        await BookManager.bookmark(book: book)
        self.isBookmark = true
    }
    
    func unbookmark(book: Book) async {
        await BookManager.unbookmark(book: book)
        self.isBookmark = false
    }
    
    private func isBookmark(isbn: String) async {
        self.isBookmark = await BookManager.isBookmark(isbn: isbn)
    }
}
