//
//  BookmarkListViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import Foundation

@Observable
class BookmarkListViewModel {
    var bookList: [Book] = []
    
    init() {
        Task {
            await loadAllBookmarkBooks()
        }
    }
    
    private func loadAllBookmarkBooks() async {
        self.bookList = await BookManager.loadAllBookmarkBooks()
    }
}
