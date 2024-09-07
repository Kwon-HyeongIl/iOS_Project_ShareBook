//
//  Post.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import Foundation

struct Post: Codable, Identifiable, Hashable, Equatable {
    let id: String
    let userId: String
    
    let impressivePhrase: String
    let feelingCaption: String
    
    var likeCount: Int
    let date: Date
    
    let book: Book
    let bookTitleKeywords: [String]
    let genre: Genre
    
    let user: User
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, impressivePhrase: "네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다", feelingCaption: "느낌", likeCount: 30, date: Date(), book: Book.DUMMY_BOOK, bookTitleKeywords: [""], genre: .studying, user: User.DUMMY_USER)
}
