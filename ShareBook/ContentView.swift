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
            LoginView()
                .environment(signupViewModel)
            
            if !isContentReady {
                SplashView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isContentReady = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
