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
    
    init(book: Book) {
        self.book = book
    }
}
