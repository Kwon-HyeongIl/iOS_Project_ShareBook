//
//  Report.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation

struct Report: Codable, Identifiable {
    let id: String

    let reportUserId: String
    let reportedPostId: String
    let date: Date
}
