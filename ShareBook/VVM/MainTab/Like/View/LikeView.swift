//
//  LikesView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikeView: View {
    @State private var selectedTab: LikeTab = .likePosts
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                VStack(spacing: 0) {
                    LikesHeadTabView(selectedTab: $selectedTab)
                    
                    ScrollView {
                        switch selectedTab {
                        case .likePosts:
                            LikePostView(proxyWidth: proxy.size.width)
                            
                        case .bookmarkBooks:
                            BookmarkBookView()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("관심")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                }
            }
        }
    }
}

#Preview {
    LikeView()
}
