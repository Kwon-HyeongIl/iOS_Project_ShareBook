//
//  LikesView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikeView: View {
    @State private var selectedTab: LikeTab = .likePosts
    
    // 뷰 캐싱
    @State private var likePostView = LikePostView()
    @State private var bookmarkBookView = BookmarkBookView()
    
    var body: some View {
        GradientBackgroundView {
            VStack(spacing: 0) {
                LikesHeadTabView(selectedTab: $selectedTab)
                
                ScrollView {
                    switch selectedTab {
                        
                    case .likePosts:
                        likePostView
                        
                    case .bookmarkBooks:
                        bookmarkBookView
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("관심")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    LikeView()
}
