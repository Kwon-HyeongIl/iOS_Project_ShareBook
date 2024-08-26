//
//  AuthManager.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var isAlert = false
    var errorMessage = ""
    
    var currentUser: User?
    
    init() {
        Task {
            await loadCurrentUserData()
        }
    }
    
    func createUser(email: String, password: String, username: String, kakaoHashedUid: String = "", appleHashedUid: String = "") async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            
            if kakaoHashedUid.isEmpty && appleHashedUid.isEmpty { // 베이직 화원가입
                await uploadUserData(userId: userId, email: email, username: username)
                
            } else if kakaoHashedUid.isEmpty { // 애플 회원가입
                await uploadUserData(userId: userId, email: email, username: username, appleHashedUid: appleHashedUid)
                
            } else { // 카카오 회원가입
                await uploadUserData(userId: userId, email: email, username: username, kakaoHashedUid: kakaoHashedUid)
            }
            
        } catch {
            print("회원가입 에러, \(error.localizedDescription)")
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    func uploadUserData(userId: String, email: String, username: String, kakaoHashedUid: String = "", appleHashedUid: String = "") async {
        if kakaoHashedUid.isEmpty && appleHashedUid.isEmpty { // 베이직 회원가입
            self.currentUser = User(id: userId, username: username, authEmail: email)
            
        } else if kakaoHashedUid.isEmpty { // 애플 회원가입
            self.currentUser = User(id: userId, username: username, authEmail: email, appleHashedUid: appleHashedUid)
            
        } else { // 카카오 회원가입
            self.currentUser = User(id: userId, username: username, authEmail: email, kakaoHashedUid: kakaoHashedUid)
        }
        
        do {
            let encodedUser = try Firestore.Encoder().encode(currentUser)
            try await Firestore.firestore()
                .collection("Users").document(userId).setData(encodedUser)
            
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    func login(email: String, password: String) async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            await loadCurrentUserData()
            
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    func loadCurrentUserData() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            self.currentUser = try await Firestore.firestore()
                .collection("Users").document(userId).getDocument(as: User.self)
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    
    
    func signout() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
