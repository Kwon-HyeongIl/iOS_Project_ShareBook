//
//  User.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import Foundation
import FirebaseAuth

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let username: String
    
    var profileImageUrl: String?
}
