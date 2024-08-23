//
//  UploadPostViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import Foundation

@Observable
class BookSearchUploadPostViewModel {
    var book: Book
    
    var impressivePhrase = ""
    var feelingCaption = ""
    var genre = Genre.humanities
    
    init(book: Book) {
        self.book = book
    }
    
    func uploadPost() async {
        await PostManager.uploadPost(impressivePhrase: impressivePhrase, feelingCaption: feelingCaption, genre: genre, book: book)
    }
}