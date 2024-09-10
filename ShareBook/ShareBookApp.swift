//
//  ShareBookApp.swift
//  ShareBook
//
//  Created by 권형일 on 7/20/24.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct ShareBookApp: App {
    @State private var navStackControlTower = NavRouter()
    @State private var mainTabCapsule = MainTabCapsule()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
    
    init() {
        // Kakao 로그인 관련 초기화
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navStackControlTower.path) {
                ContentView()
                    .navigationDestination(for: NavStackView.self) { view in
                        navStackControlTower.navigate(to: view)
                    }
                    .onOpenURL { url in
                        
                        // Kakao 로그인 URL 처리
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
            .tint(.black)
        }
        .environment(navStackControlTower)
        .environment(mainTabCapsule)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("토큰을 수신")
    
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        print(dataDict)
        
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        print(userInfo)
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        completionHandler()
    }
}
