//
//  Post.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let userId: String
    let impressivePhrase: String
    let caption: String
    var like: Int
    let date: Date
    
    let book: Book
}
