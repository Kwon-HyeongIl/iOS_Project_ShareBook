//
//  FeedbackViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import Foundation

@Observable
class FeedbackViewModel {
    var content = ""
    
    func feedback() async {
        await UserSupportService.feedback(content: content)
    }
}
