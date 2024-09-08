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
        self.currentUser = AuthManager.shared.currentUser
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        @Bindable var mainTabCapsule = mainTabCapsule
        
        VStack(spacing: 0) {
            ZStack {
                switch mainTabCapsule.selectedTab {
                    
                case .house:
                    HomeView()
                    
                case .plusSquareOnSquare:
                    NewPostView()
                    
                case .heart:
                    LikeView()
                    
                case .person:
                    ProfileView(user: currentUser, commentSheetCapsule: nil)
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
        .environment(NavRouter())
}
