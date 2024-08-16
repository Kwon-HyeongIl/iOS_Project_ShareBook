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
    let feelingCaption: String
    var like: Int
    let date: Date
    
    let book: Book
    let user: User
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, impressivePhrase: "\"네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다\"", feelingCaption: "느낌", like: 30, date: Date(), book: Book.DUMMY_BOOK, user: User.DUMMY_USER)
}
