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
    @State private var signupViewModel = SignupViewModel()
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
        .environment(signupViewModel)
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
    
    func refreshDeviceToken() {
        Messaging.messaging().deleteToken { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            // 새 토큰 요청
            Messaging.messaging().token { token, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                if let token {
                    FCMManager.shared.myDeviceToken = token
                }
            }
        }
    }
}

extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        print("token:", dataDict["token"] ?? "")
        
        FCMManager.shared.myDeviceToken = dataDict["token"] ?? ""
    }
}

// 메세지 수신
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있는 동안 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 알림을 클릭했을 때 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        completionHandler()
    }
}
