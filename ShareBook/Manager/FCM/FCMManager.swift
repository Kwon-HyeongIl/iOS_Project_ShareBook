//
//  FCMManager.swift
//  ShareBook
//
//  Created by 권형일 on 9/11/24.
//

import SwiftUI

@Observable
class FCMManager {
    static let shared = FCMManager()
    
    var myDeviceToken: String?
    var googleAccessToken: String?
    
    func sendFCMNotification(deviceToken: String, title: String, body: String) async {
        await self.getGoogleOAuthAccessToken()
        
        guard let projectId = Bundle.main.infoDictionary?["FIREBASE_SHAREBOOK_PROJECT_ID"] as? String else {
            return
        }
        
        guard let url = URL(string: "https://fcm.googleapis.com/v1/projects/\(projectId)/messages:send") else {
            print("Invalid URL for FCM")
            return
        }
        
        let json: [String: Any] = [
            "message": [
                "token": deviceToken,
                "notification": [
                    "body": body,
                    "title": title
                ]
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        request.setValue("Bearer \(googleAccessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { _, _, error in
            if let error {
                print(error.localizedDescription)
                return
            }
        }
        .resume()
    }
    
    private func getGoogleOAuthAccessToken() async {
        guard let accessTokenUrlBody = Bundle.main.infoDictionary?["GOOGLE_OAUTH_ACCESS_TOKEN_URL_BODY"] as? String else {
            return
        }
        
        guard let url = URL(string: "https://\(accessTokenUrlBody)") else {
            print("Invalid URL for token")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request) 
                // Token을 받고 나서 계속 알림 요청을 보내기 위해 URLSession.shared.data 사용
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let accessTokenData = json["accessToken"] as? [String: Any],
               let token = accessTokenData["token"] as? String {
                self.googleAccessToken = token
                
            } else {
                print("Invalid response")
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
