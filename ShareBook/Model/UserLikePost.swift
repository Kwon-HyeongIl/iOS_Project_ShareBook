//
//  UserLikePost.swift
//  ShareBook
//
//  Created by 권형일 on 8/25/24.
//

import Foundation

struct UserLikePost: Codable, Identifiable {
    let id: String
    
    let postId: String
    let date: Date
}
