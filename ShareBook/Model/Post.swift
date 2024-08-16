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
    
    var likeCount: Int
    let date: Date
    
    let book: Book
    let genre: Genre
    
    let user: User
}

enum Genre: Codable {
    case humanities
    case self_improvement
    case animation
    case studying
    case fiction
    case detective
    case mystery
    case scientific
    case health
    case cooking
    case traveling
    case history
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, impressivePhrase: "네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다", feelingCaption: "느낌", likeCount: 30, date: Date(), book: Book.DUMMY_BOOK, genre: .studying, user: User.DUMMY_USER)
}
