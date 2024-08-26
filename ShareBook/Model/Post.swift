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
    let genre: Genre
    
    let user: User
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id &&
        lhs.userId == rhs.userId &&
        lhs.impressivePhrase == rhs.impressivePhrase &&
        lhs.feelingCaption == rhs.feelingCaption &&
        lhs.likeCount == rhs.likeCount &&
        lhs.date == rhs.date &&
        lhs.book == rhs.book &&
        lhs.genre == rhs.genre &&
        lhs.user == rhs.user
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
        hasher.combine(impressivePhrase)
        hasher.combine(feelingCaption)
        hasher.combine(likeCount)
        hasher.combine(date)
        hasher.combine(book)
        hasher.combine(genre)
        hasher.combine(user)
    }
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, impressivePhrase: "네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다", feelingCaption: "느낌", likeCount: 30, date: Date(), book: Book.DUMMY_BOOK, genre: .studying, user: User.DUMMY_USER)
}
