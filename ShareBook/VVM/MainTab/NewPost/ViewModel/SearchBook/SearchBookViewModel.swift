//
//  NewPostSearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import Foundation

@Observable
class SearchBookViewModel {
    var bookList = [Book]()
    
    var searchText = ""
    var isRedacted = false
    var isShowing = true
    
    func searchBookWithTitle(searchQuery: String) {
        BookManager.requestSearchBookList(searchQuery: searchQuery) { books in
            DispatchQueue.main.async {
                self.bookList = books
            }
        }
    }
}
