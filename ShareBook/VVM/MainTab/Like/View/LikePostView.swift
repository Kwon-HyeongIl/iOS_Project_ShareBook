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
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        if !viewModel.isRedacted {
                            ForEach(viewModel.posts) { post in
                                PostCoverView(post: post)
                                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                            }
                            
                        } else {
                            ForEach(0..<10) { _ in
                                DummyPostCoverView(isHotPost: false)
                            }
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
            }
        }
        .task {
            if viewModel.isFirstLoad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        viewModel.isRedacted = false
                    }
                }
                
                viewModel.isFirstLoad = false
            }
        }
        
    }
}

#Preview {
    LikePostView()
}
