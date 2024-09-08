//
//  MainTab.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import Foundation

enum MainTab: String, CaseIterable {
    case house = "house"
    case plusSquareOnSquare = "plus.square.on.square"
    case heart = "heart"
    case person = "person"
    
    var title: String {
        switch self {
        case .house:
            "메인"
            
        case .plusSquareOnSquare:
            "작성"
            
        case .heart:
            "관심"
            
        case .person:
            "프로필"
        }
    }
}
