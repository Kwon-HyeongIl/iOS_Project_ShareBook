//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var navStackControlTower = NavStackControlTower()
    @State private var selectedMainTabCapsule = SelectedMainTabCapsule()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        let currentUser = AuthManager.shared.currentUser
        
        NavigationStack(path: $navStackControlTower.path) {
            ZStack {
                switch selectedMainTabCapsule.selectedTab {
                    
                case .house:
                    HomeView()
                    
                case .plusSquareOnSquare:
                    NewPostView()
                    
                case .heart:
                    LikeView()
                    
                case .person:
                    ProfileView(user: currentUser)
                }
                
                VStack {
                    Spacer()
                    MainCustomTabView()
                }
            }
            .navigationDestination(for: NavStackView.self) { view in
                navStackControlTower.navigate(to: view)
            }
        }
        .environment(navStackControlTower)
        .environment(selectedMainTabCapsule)
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
