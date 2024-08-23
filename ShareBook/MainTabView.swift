//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                switch selectedTab {
                case .house:
                    HomeView()
                    
                case .plusMagnifyngglass:
                    BookSearchView(selectedTab: $selectedTab)
                    
                case .heart:
                    LikesView()
                    
                case .person:
                    ProfileView()
                }
                
                VStack {
                    Spacer()
                    CustomTabView(selectedTab: $selectedTab)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
