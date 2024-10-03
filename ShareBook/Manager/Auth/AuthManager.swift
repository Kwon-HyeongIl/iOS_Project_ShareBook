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
    
    private func uploadUserData(userId: String, email: String, username: String, kakaoHashedUid: String = "", appleHashedUid: String = "") async {
        let deviceToken = FCMManager.shared.myDeviceToken ?? ""
        
        if kakaoHashedUid.isEmpty && appleHashedUid.isEmpty {
            // 베이직 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email, notificationType: [.comment, .like, .follow], titleGenre: .all)
            
        } else if kakaoHashedUid.isEmpty { 
            // 애플 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email, appleHashedUid: appleHashedUid, notificationType: [.comment, .like, .follow], titleGenre: .all)
            
        } else { 
            // 카카오 회원가입
            self.currentUser = User(id: userId, deviceToken: deviceToken, username: username, authEmail: email, kakaoHashedUid: kakaoHashedUid, notificationType: [.comment, .like, .follow], titleGenre: .all)
        }
        
        do {
            let encodedUser = try Firestore.Encoder().encode(currentUser)
            try await Firestore.firestore()
                .collection("User").document(userId).setData(encodedUser)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login(email: String, password: String) async -> Bool {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            await updateDeviceToken()
            await loadCurrentUserData()
            
            return true
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func checkEmailDuplication(email: String) async -> Bool {
        do {
            return try await Firestore.firestore()
                .collection("User").whereField("authEmail", isEqualTo: email).getDocuments().documents.isEmpty
            
        }  catch {
            return false
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
    
    func loadSpecificUser(userId: String) async -> User? {
        do {
            let userDocument = try await Firestore.firestore()
                .collection("User").document(userId)
                .getDocument()
            
            return try userDocument.data(as: User.self)
            
        } catch {
            print(error.localizedDescription)
            return nil
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
    
    func deleteAccount() {
        if  let user = Auth.auth().currentUser {
            user.delete { error in
                if let error {
                    print(error.localizedDescription)
                } else {
                    // 삭제 성공
                    Task {
                        await self.markUserDeleted()
                        self.currentUser = nil
                    }
                }
            }
        } 
    }
    
    private func markUserDeleted() async {
        do {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            var editedData: [String : Any] = [:]
            editedData["isAccountDeleted"] = true
            
            try await Firestore.firestore()
                .collection("User").document(userId)
                .updateData(editedData)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
