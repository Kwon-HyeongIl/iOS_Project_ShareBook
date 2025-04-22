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
    
    // MainTabViews 캐싱
    @State private var homeView = HomeView()
    @State private var newPostView = NewPostView()
    @State private var likeView = LikeView()
    @State private var profileView: ProfileView
    
    init() {
        self.currentUser = AuthManager.shared.currentUser
        
        UITabBar.appearance().isHidden = true
        
        self.profileView = ProfileView(userId: currentUser?.id ?? "")
    }
    
    var body: some View {
        @Bindable var mainTabCapsule = mainTabCapsule
        
        VStack(spacing: 0) {
            ZStack {
                switch mainTabCapsule.selectedTab {
                    
                case .house:
                    homeView
                    
                case .plusSquareOnSquare:
                    newPostView
                    
                case .heart:
                    likeView
                    
                case .person:
                    profileView
                }
                
                VStack {
                    Spacer()
                    MainCustomTabView()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
        .environment(MainTabCapsule())
        .environment(NavigationRouter())
}
