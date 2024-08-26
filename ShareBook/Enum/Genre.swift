//
//  Genre.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import Foundation

enum Genre: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case all = "전체"
    case humanities = "인문학"
    case self_improvement = "자기개발"
    case animation = "애니메이션"
    case studying = "공부"
    case fiction = "소설"
    case detective = "추리"
    case mystery = "미스테리"
    case scientific = "과학"
    case health = "건강"
    case cooking = "요리"
    case traveling = "여행"
    case history = "역사"
}
