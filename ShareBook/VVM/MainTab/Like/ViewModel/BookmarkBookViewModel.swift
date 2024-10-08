//
//  BookmarkBooksViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import Foundation

@Observable
class BookmarkBookViewModel {
    var books: [Book] = []
    
    var isFirstLoad = true
    var isRedacted = true
    
    init() {
        Task {
            await loadAllBookmarkBooks()
        }
    }
    
    func loadAllBookmarkBooks() async {
        self.books = await BookManager.loadAllBookmarkBooks()
    }
}
