//
//  UploadPostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import Foundation

@Observable
class NewPostUploadPostViewModel {
    var book: Book
    
    var impressivePhrase = ""
    var feelingCaption = ""
    
    init(book: Book) {
        self.book = book
    }
}
