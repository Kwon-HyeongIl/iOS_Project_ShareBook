//
//  Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    
    let commentText: String
    
    let postId: String
    let postUserId: String
    
    let commentUserId: String
    var commentUser: User?
    
    let date: Date
}

extension Comment {
    static var DUMMY_COMMENT: Comment = Comment(id: UUID().uuidString, commentText: "dummy comment", postId: UUID().uuidString, postUserId: UUID().uuidString, commentUserId: UUID().uuidString, commentUser: User.DUMMY_USER, date: Date())
}
