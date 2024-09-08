//
//  CommentSheetCapsule.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation

@Observable
class CommentSheetCapsule: Hashable, Equatable {
    var isShowing = false
    
    static func == (lhs: CommentSheetCapsule, rhs: CommentSheetCapsule) -> Bool {
        return lhs.isShowing == rhs.isShowing
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(isShowing)
    }
}
