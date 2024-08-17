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

enum Genre: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case humanities = "인문학"
    case self_improvement = "자기개발"
    case animation = "애니메이션"
    case studying = "공부"
    case fiction = "소설"
    case detective = "추리"
    case mystery = "미스테리"
    case scientific = "과학"
    case health = "건강"
    case cooking = "요리"
    case traveling = "여행"
    case history = "역사"
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, impressivePhrase: "네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다", feelingCaption: "느낌", likeCount: 30, date: Date(), book: Book.DUMMY_BOOK, genre: .studying, user: User.DUMMY_USER)
}
