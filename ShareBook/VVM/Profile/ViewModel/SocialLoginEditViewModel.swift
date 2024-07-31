//
//  SocialLoginEditViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 7/31/24.
//

import Foundation

@Observable
class SocialLoginEditViewModel {
    var isKakapLogin = false
    var isAppleLogin = false
    
    init() {
        Task {
            await checkLogin()
        }
    }
    
    func checkLogin() async {
        let user = AuthManager.shared.currentUser
        
        if let _ = user?.kakaoHashedUid, let _ = user?.appleHashedUid {
            isKakapLogin = true
            isAppleLogin = true
        } else if let _ = user?.kakaoHashedUid {
            isKakapLogin = true
        } else {
            isAppleLogin = true
        }
    }
    
}
