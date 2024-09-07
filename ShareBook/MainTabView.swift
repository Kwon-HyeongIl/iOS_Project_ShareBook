//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(MainTabIndexCapsule.self) var mainTabIndexCapsule
    
    let currentUser: User?
    
    init() {
        self.currentUser = AuthManager.shared.currentUser
    }
    
    var body: some View {
        @Bindable var mainTabIndexCapsule = mainTabIndexCapsule
        
        TabView(selection: $mainTabIndexCapsule.index) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            NewPostView()
                .tabItem {
                    Image(systemName: "plus.square.on.square")
                }
                .tag(1)
            
            LikeView()
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(2)
            
            ProfileView(user: currentUser, commentSheetCapsule: nil)
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
        .environment(MainTabIndexCapsule())
}
