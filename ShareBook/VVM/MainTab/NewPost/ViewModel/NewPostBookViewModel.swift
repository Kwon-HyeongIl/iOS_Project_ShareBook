//
//  BookViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/9/24.
//

import Foundation

@Observable
class NewPostBookViewModel: Hashable, Equatable {
    static func == (lhs: NewPostBookViewModel, rhs: NewPostBookViewModel) -> Bool {
        return lhs.book == rhs.book && lhs.isBookmark == rhs.isBookmark
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(book)
        hasher.combine(isBookmark)
    }
    
    var book: Book
    var isBookmark = false
    
    init(book: Book) {
        self.book = book
        self.book.pubdate = convertDateFormat(book: book)
        
        Task {
            await isBookmark()
        }
    }
    
    func convertDateFormat(book: Book) -> String {
        let rawDate = book.pubdate
        
        let year = rawDate.prefix(4)
        let month = rawDate.dropFirst(4).prefix(2)
        let day = rawDate.suffix(2)
        
        return "\(year).\(month).\(day)"
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
