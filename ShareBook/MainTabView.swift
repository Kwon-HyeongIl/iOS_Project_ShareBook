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
        NavigationStack {
            ZStack {
                switch selectedTab {
                case .house:
                    PostsView()
                    
                case .plusSquareOnSquare:
                    NewPostSearchView()
                    
                case .booksVertical:
                    MyPostsView()
                    
                case .personCropCircle:
                    ProfileView()
                }
                
                VStack {
                    Spacer()
                    CustomTabView(selectedTab: $selectedTab)
                }
            }
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
