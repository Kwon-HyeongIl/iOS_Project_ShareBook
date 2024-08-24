//
//  LikePostsView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikePostsView: View {
    @State private var viewModel = LikePostsViewModel()
    
    let proxyWidth: CGFloat
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: viewModel.calNumBase26And393(geometryWidth: proxyWidth)) {
                    ForEach(viewModel.posts) { post in
                        PostCoverView(post: post)
                            .scaleEffect(proxyWidth / 380)
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
        
    }
}

#Preview {
    LikePostsView(proxyWidth: 100)
}
