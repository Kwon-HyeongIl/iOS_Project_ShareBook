//
//  SearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

@Observable
class NewPostSearchViewModel {
    var bookList = [Book]()
    
    func searchBookWithTitle(searchQuery: String) {
        HttpManager.requestSearchBookList(searchQuery: searchQuery)
        self.bookList = HttpManager.getBookList()
    }
}
