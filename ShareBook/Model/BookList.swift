//
//  BookList.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

struct BookList: Codable {
    let total: Int
    let start: Int
    let display: Int
    let items: [Book]
}
