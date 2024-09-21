//
//  SearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

@Observable
class NewPostViewModel {
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
