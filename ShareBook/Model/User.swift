//
//  User.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import Foundation
import FirebaseAuth

struct User: Codable, Identifiable, Hashable, Equatable {
    let id: String
    let username: String
    
    var authEmail: String
    var kakaoHashedUid: String?
    var appleHashedUid: String?

    var contactEmail: String?
    
    var profileImageUrl: String?
    
    var titleGenre: Genre?
    var titleBookImageUrl: String?
    var titleBookImpressivePhrase: String?
    var titlePostId: String?
}

extension User {
    static var DUMMY_USER: User = User(id: UUID().uuidString, username: "행이", authEmail: "test@naver.com", titleBookImpressivePhrase: "가나다라마바사 아자차카타파하 에이비씨디이에프지 에이치아이제이케이 testestestsetsetsetsetsetsetsetsetsetsetsetsetsetsetsetset")
}
