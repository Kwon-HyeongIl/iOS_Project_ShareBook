//
//  BookViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import Foundation

@Observable
class BookViewModel: Hashable, Equatable {
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
    
    func unBookmark() async {
        await BookManager.unBookmark(book: self.book)
        self.isBookmark = false
    }
    
    private func isBookmark() async {
        self.isBookmark = await BookManager.isBookmark(isbn: self.book.isbn)
    }
    
    static func == (lhs: BookViewModel, rhs: BookViewModel) -> Bool {
        return lhs.book.isbn == rhs.book.isbn
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(book.isbn)
    }
}
