//
//  ShareBookApp.swift
//  ShareBook
//
//  Created by 권형일 on 7/20/24.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ShareBookApp: App {
    @State private var navStackControlTower = NavStackControlTower()
    @State private var mainTabIndexCapsule = MainTabIndexCapsule()
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
        .environment(mainTabIndexCapsule)
    }
}
