//
//  LoginViewModel+Apple.swift
//  ShareBook
//
//  Created by 권형일 on 7/26/24.
//

import Foundation
import AuthenticationServices

extension LoginViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func appleAuthSignin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 로그인 성공시 (내부적으로 호출)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = (appleIDCredential.fullName?.familyName ?? "") + (appleIDCredential.fullName?.givenName ?? "")
//            guard let email = appleIDCredential.email else { return }
            guard let email = JwtManager.extractEmailFromJwt(from: String(data: appleIDCredential.identityToken!, encoding: .utf8) ?? "") else { return }
            
            //            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
            //            let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
            
            Task {
                if await AuthManager.shared.isEmailExist(email: email) { // 기존에 가입했던 경우
                    await AuthManager.shared.login(email: email, password: userIdentifier)
                } else { // 회원가입
                    await AuthManager.shared.createUser(email: email, password: userIdentifier, username: fullName)
                }
            }
        }
    }
    
    // 로그인 실패시 (내부적으로 호출)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Failed: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first { $0.isKeyWindow } ?? UIWindow()
    }
}
