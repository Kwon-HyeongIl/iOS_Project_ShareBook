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
            
            /*
             if문의 조건이 충족 될 때, if문 안에 있는 뷰가 생성
             예를 들어, ContentView가 init될 때 currentUser가 nil이면 MainTabView는 생성하지 않고있음
             */
            if AuthManager.shared.currentUser != nil {
                MainTabView()
                    .toolbar(isContentReady ? .visible : .hidden, for: .navigationBar)

            } else {
                LoginView()
                    .environment(signupViewModel)
            }
            
            if !isContentReady {
                SplashView()
                    .animation(.easeOut(duration: 0.4), value: isContentReady)
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isContentReady = true
            }
        }
    }
}

#Preview {
    ContentView()
}
