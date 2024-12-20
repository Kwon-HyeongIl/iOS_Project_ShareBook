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
    
    var isNotificationBadge: Bool?
    var notificationType: [NotificationType]
    
    var titleGenre: Genre?
    var titlePostId: String?
    
    var isAccountDeleted: Bool?
}

extension User {
    static var DUMMY_USER: User = User(id: UUID().uuidString, deviceToken: "test", username: "행일이삼사오", authEmail: "test@naver.com", notificationType: [.comment, .like, .follow], titleGenre: Genre.humanities)
}
