//
//  ContentView.swift
//  ShareBook
//
//  Created by 권형일 on 7/20/24.
//

import SwiftUI

struct ContentView: View {
    @State var signupViewModel = SignupViewModel()
    @State var isContentReady = false
    
    var body: some View {
        ZStack {
            if let currentUser = AuthManager.shared.currentUser {
                MainTabView(currentUser: currentUser)

            } else {
                LoginView()
                    .environment(signupViewModel)
            }
            
            SplashView()
                .opacity(isContentReady ? 0 : 1)
                .animation(.easeOut(duration: 0.4), value: isContentReady)
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                isContentReady = true
            }
        }
    }
}

#Preview {
    ContentView()
}
