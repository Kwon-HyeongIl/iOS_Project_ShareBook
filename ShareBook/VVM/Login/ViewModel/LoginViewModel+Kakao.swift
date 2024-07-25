//
//  LoginViewModel+Kakao.swift
//  ShareBook
//
//  Created by 권형일 on 7/24/24.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth

extension LoginViewModel {
    func kakaoAuthSignIn() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                if let error = error { // 유효하지 않은 토큰
                    self.openKakaoService()
                } else { // 유효한 토큰
                    self.continueFirebaseAuthWithKakao()
                }
            }
        } else { // 토큰이 없는 경우
            self.openKakaoService()
        }
    }
    
    func openKakaoService() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in // 카카오톡 앱으로 로그인
                if let error = error {
                    //로그인 실패
                    print("Kakao Sign In Error: ", error.localizedDescription)
                    return
                }
                
                // 로그인 성공
                _ = oauthToken
                self.continueFirebaseAuthWithKakao()
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in // 카카오 웹으로 로그인
                if let error = error {
                    // 로그인 실패
                    print("Kakao Sign In Error: ", error.localizedDescription)
                    return
                }
                
                // 로그인 성공
                _ = oauthToken
                self.continueFirebaseAuthWithKakao()
            }
        }
    }
    
    func continueFirebaseAuthWithKakao() {
        UserApi.shared.me { kakaoUser, error in
            if let error {
                print("Kakao Sign In Error: ", error.localizedDescription)
                return
            }
            
            guard let email = kakaoUser?.kakaoAccount?.email else { return }
            guard let password = kakaoUser?.id else { return }
            guard let username = kakaoUser?.kakaoAccount?.profile?.nickname else { return }
            
            Task {
                if await AuthManager.shared.isEmailExist(email: email) { // 기존에 가입했던 경우
                    await AuthManager.shared.login(email: email, password: String(password))
                } else { // 회원가입
                    await AuthManager.shared.createUser(email: email, password: String(password), username: username)
                }
            }
        }
    }
}
