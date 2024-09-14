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
            print(error.localizedDescription)
        }
    }
    
    func uploadUserData(userId: String, email: String, username: String, kakaoHashedUid: String = "", appleHashedUid: String = "") async {
        let deviceToken = FCMManager.shared.myDeviceToken ?? ""
        
        if kakaoHashedUid.isEmpty && appleHashedUid.isEmpty {
            // 베이직 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email)
            
        } else if kakaoHashedUid.isEmpty { 
            // 애플 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email, appleHashedUid: appleHashedUid)
            
        } else { 
            // 카카오 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email, kakaoHashedUid: kakaoHashedUid)
        }
        
        do {
            let encodedUser = try Firestore.Encoder().encode(currentUser)
            try await Firestore.firestore()
                .collection("User").document(userId).setData(encodedUser)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login(email: String, password: String) async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            await updateDeviceToken()
            await loadCurrentUserData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCurrentUserData() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            self.currentUser = try await Firestore.firestore()
                .collection("User").document(userId).getDocument(as: User.self)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateDeviceToken() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            var editedData: [String : Any] = [:]
            editedData["deviceToken"] = FCMManager.shared.myDeviceToken ?? ""
            
            try await Firestore.firestore()
                .collection("User").document(userId)
                .updateData(editedData)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getSpecificUserDeviceToken(userId: String) async -> String {
        do {
            let userDocument = try await Firestore.firestore()
                .collection("User").document(userId)
                .getDocument()
            
            let user = try userDocument.data(as: User.self)
            
            return user.deviceToken
            
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
