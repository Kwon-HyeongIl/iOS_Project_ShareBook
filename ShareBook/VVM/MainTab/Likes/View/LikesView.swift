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
        GeometryReader { proxy in
            GradientBackgroundView {
                VStack(spacing: 0) {
                    HStack {
                        Text("관심")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    LikesHeadTabView(selectedTab: $selectedTab)
                    
                    ScrollView {
                        switch selectedTab {
                        case .likePosts:
                            LikePostsView(proxyWidth: proxy.size.width)
                            
                        case .bookmarkBooks:
                            BookmarkBooksView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LikesView()
}
