//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(MainTabCapsule.self) var mainTabCapsule
    
    let currentUser: User?
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        self.currentUser = AuthManager.shared.currentUser
    }
    
    var body: some View {
        @Bindable var mainTabCapsule = mainTabCapsule
        
        TabView(selection: $mainTabCapsule.index) {
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
        .tint(.sBColor)
    }
}

#Preview {
    MainTabView()
        .environment(MainTabCapsule())
        .environment(NavRouter())
}
