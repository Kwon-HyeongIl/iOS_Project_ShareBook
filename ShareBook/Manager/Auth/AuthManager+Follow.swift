//
//  AuthManager+Follow.swift
//  ShareBook
//
//  Created by 권형일 on 8/27/24.
//

import Foundation
import FirebaseFirestore

extension AuthManager {
    func follow(followUserId: String) async {
        
        // 💌 FCM
        let postUserDeviceToken = await AuthManager.shared.getSpecificUserDeviceToken(userId: followUserId)
        await FCMManager.shared.sendFCMNotification(deviceToken: postUserDeviceToken, title: "팔로우", body: "\(currentUser?.username ?? "")님이 당신을 팔로우하였습니다!")
        
        guard let currentUserId = currentUser?.id else { return }
        
        do {
            async let _ = try await Firestore.firestore()
                .collection("User").document(currentUserId)
                .collection("User_Following").document(followUserId)
                .setData([:])
            
            async let _ = try await Firestore.firestore()
                .collection("User").document(followUserId)
                .collection("User_Follower").document(currentUserId)
                .setData([:])
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func unFollow(unFollowUserId: String) async {
        guard let currentUserId = currentUser?.id else { return }
        
        do {
            async let _ = try await Firestore.firestore()
                .collection("User").document(currentUserId)
                .collection("User_Following").document(unFollowUserId)
                .delete()
            
            async let _ = try await Firestore.firestore()
                .collection("User").document(unFollowUserId)
                .collection("User_Follower").document(currentUserId)
                .delete()
            
        } catch {
            print(error.localizedDescription)
        }
    }

    func isFollow(userId: String) async -> Bool {
        guard let currentUserId = currentUser?.id else { return false }
        
        do {
            return try await Firestore.firestore()
                .collection("User").document(currentUserId)
                .collection("User_Following").document(userId)
                .getDocument().exists
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func loadFollowingCount(userId: String) async -> Int {
        do {
            return try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("User_Following").getDocuments()
                .count
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func loadFollowerCount(userId: String) async -> Int {
        do {
            return try await Firestore.firestore()
                .collection("User").document(userId)
                .collection("User_Follower").getDocuments()
                .count
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}
