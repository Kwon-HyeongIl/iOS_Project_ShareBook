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
    
    func createUser(email: String, password: String, name: String, username: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            await uploadUserData(userId: userId, email: email, name: name, username: username)
            
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    func uploadUserData(userId: String, email: String, name: String, username: String) async {
        self.currentUser = User(id: userId, email: email, name: name, username: username)
        
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
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            await loadCurrentUserData()
            
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
    
    func loadCurrentUserData() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else { throw MyError.internalAuthError }
            self.currentUser = try await Firestore.firestore()
                .collection("Users").document(userId).getDocument(as: User.self)
        } catch {
            errorMessage = "인증 관련 오류"
            isAlert = true
            return
        }
    }
}
