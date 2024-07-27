//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
            
            NewPostView()
                .tabItem {
                    Image(systemName: "plus.square.on.square")
                }
                .tag(1)
            
            PostsView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(2)
            
            MyPostsView()
                .tabItem {
                    Image(systemName: "books.vertical")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .tag(4)
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
