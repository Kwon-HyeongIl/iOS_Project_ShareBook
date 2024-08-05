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
            await isBookmark()
        }
    }
    
    func bookmark() async {
        await BookManager.bookmark(book: self.book)
        self.isBookmark = true
    }
    
    func unbookmark() async {
        await BookManager.unbookmark(book: self.book)
        self.isBookmark = false
    }
    
    private func isBookmark() async {
        self.isBookmark = await BookManager.isBookmark(isbn: self.book.isbn)
    }
}
