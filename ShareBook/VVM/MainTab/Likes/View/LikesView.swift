//
//  LikesView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikesView: View {
    @State private var selectedTab: LikesTab = .likePosts
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("관심")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.bottom)
            
            LikesHeadTabView(selectedTab: $selectedTab)
            
            ScrollView {
                switch selectedTab {
                case .likePosts:
                    LikePostsView()
                    
                case .bookmarkBooks:
                    BookmarkBooksView()
                }
            }
        }
    }
}

#Preview {
    LikesView()
}
