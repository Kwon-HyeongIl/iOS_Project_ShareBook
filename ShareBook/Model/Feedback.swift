//
//  Feedback.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation

struct Feedback: Codable, Identifiable {
    let id: String
    
    let userId: String
    let content: String
}
