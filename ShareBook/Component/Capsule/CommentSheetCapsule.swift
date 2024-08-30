//
//  CommentSheetCapsule.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation

@Observable
class CommentSheetCapsule: Hashable, Equatable {
    var isCommentSheetShowing = false
    
    static func == (lhs: CommentSheetCapsule, rhs: CommentSheetCapsule) -> Bool {
        return lhs.isCommentSheetShowing == rhs.isCommentSheetShowing
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(isCommentSheetShowing)
    }
}
