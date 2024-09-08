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
            if AuthManager.shared.currentUser != nil {
                MainTabView()

            } else {
                LoginView()
                    .environment(signupViewModel)
            }
            
            if !isContentReady {
                SplashView()
                    .animation(.easeOut(duration: 0.4), value: isContentReady)
                    .toolbar(.hidden, for: .navigationBar) // 모든 뷰 계층에 영향
            }
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
