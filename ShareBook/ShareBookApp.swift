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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
            KakaoSDK.initSDK(appKey: "c455ea82c5cc6e5b3680978240a0acac")
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL(perform: { url in
                            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                AuthController.handleOpenUrl(url: url)
                            }
                        })
        }
    }
}
