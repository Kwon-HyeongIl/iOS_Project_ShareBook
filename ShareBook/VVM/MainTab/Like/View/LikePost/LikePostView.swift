//
//  LikePostsView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikePostView: View {
    @Environment(NavigationControlTower.self) var navControlTower: NavigationControlTower
    @State private var viewModel = LikePostViewModel()
    
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
                        navControlTower.navigate(to: .PostCoverView(post))
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
    LikePostView(proxyWidth: 100)
        .environment(NavigationControlTower())
}
