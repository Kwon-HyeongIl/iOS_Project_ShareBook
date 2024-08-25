//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTabCapsule = SelectedTabCapsule()
    @State private var stackActiveCapsule = StackActiveCapsule()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                switch selectedTabCapsule.selectedTab {
                case .house:
                    HomeView()
                    
                case .plusSquareOnSquare :
                    NewPostView()
                    
                case .heart:
                    LikesView()
                    
                case .person:
                    ProfileView()
                }
                
                VStack {
                    Spacer()
                    CustomTabView()
                }
            }
        }
        .environment(selectedTabCapsule)
        .environment(stackActiveCapsule)
        .navigationViewStyle(StackNavigationViewStyle())
        .tint(.black)
    }
}

@Observable
class SelectedTabCapsule {
    var selectedTab: MainTab = .house
}

@Observable
class StackActiveCapsule {
    var stackActive = false
}

#Preview {
    MainTabView()
}
