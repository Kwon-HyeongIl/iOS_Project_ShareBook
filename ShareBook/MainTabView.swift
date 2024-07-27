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
            PostsView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            NewPostSearchView()
                .tabItem {
                    Image(systemName: "plus.square.on.square")
                }
                .tag(1)
            
            MyPostsView()
                .tabItem {
                    Image(systemName: "books.vertical")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .tag(3)
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
