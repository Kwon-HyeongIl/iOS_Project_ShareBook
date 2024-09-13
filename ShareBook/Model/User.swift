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
    var deviceToken: String
    let username: String
    
    var authEmail: String
    var kakaoHashedUid: String?
    var appleHashedUid: String?

    var contactEmail: String?
    
    var profileImageUrl: String?
    
    var titleGenre: Genre?
    var titlePostId: String?
}

extension User {
    static var DUMMY_USER: User = User(id: UUID().uuidString, deviceToken: "test", username: "행이", authEmail: "test@naver.com")
}
