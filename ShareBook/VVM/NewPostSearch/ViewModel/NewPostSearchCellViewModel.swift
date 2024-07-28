//
//  SearchCellViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

@Observable
class NewPostSearchCellViewModel {
    var book: Book
    
    init(book: Book) {
        self.book = book
        self.book.pubdate = convertDateFormat(book: book)
    }
    
    func convertDateFormat(book: Book) -> String {
        let rawDate = book.pubdate
        
        let year = rawDate.prefix(4)
        let month = rawDate.dropFirst(4).prefix(2)
        let day = rawDate.suffix(2)
        
        return "\(year).\(month).\(day)"
    }
}
