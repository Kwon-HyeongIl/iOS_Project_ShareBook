//
//  PostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct PostsView: View {
    @State private var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationStack {
            GradientBackgroundView {
                VStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .frame(width: 100)
                    
                    ScrollView {
                        HStack {
                            Text("전체 책")
                                .fontWeight(.semibold)
                                .font(.title)
                                .frame(width: 100, height: 50)
                                .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                .padding(.leading, 30)
                            
                            Spacer()
                        }
                        
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.posts) { post in
                                    PostCoverView(post: post)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .refreshable {
                        await viewModel.loadAllPost()
                    }
                    .task {
                        await viewModel.loadAllPost()
                    }
                }
            }
        }
    }
}

#Preview {
    PostsView()
}
