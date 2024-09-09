//
//  LikePostsView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI
import Shimmer

struct LikePostView: View {
    @State private var viewModel = LikePostViewModel()
    
    @State private var isRedacted = false
    
    let proxyWidth: CGFloat
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: viewModel.postSpacing(proxyWidth: proxyWidth)) {
                    ForEach(viewModel.posts) { post in
                        PostCoverView(post: post)
                            .redacted(reason: isRedacted ? .placeholder : [])
                            .shimmering(active: isRedacted ? true : false, bandSize: 0.4)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 5)
                
                Spacer()
            }
        }
        .task {
            Task {
                await viewModel.loadAllLikePosts()
                
                isRedacted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        isRedacted = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    LikePostView(proxyWidth: 100)
}
