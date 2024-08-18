//
//  PostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        GradientBackgroundView {
            VStack(spacing: 0) {
                Image("ShareBook_TextLogo")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .frame(width: 100)
                
                Divider()
                
                ScrollView {
                    ZStack {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.hotPosts.indices, id: \.self) { index in
                                    HomeHotPostCoverView(post: viewModel.hotPosts[index])
                                        .padding(.leading, index == 0 ? 10 : 0)
                                        .padding(.trailing, index == viewModel.hotPosts.count - 1 ? 10 : 0)
                                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                            view
                                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                        }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        HStack {
                            Text("금주의 인기 책 구절")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                .padding(.leading, 20)
                                .padding(.top)
                        }
                        .padding(.bottom, 380)
                        
                        Divider()
                            .padding(.top, 380)
                    }
                    
                    ZStack {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(viewModel.posts) { post in
                                HomePostCoverView(post: post)
                            }
                        }
                        
                        Text("모든 책 구절")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                            .padding(.leading, 20)
                            .padding(.bottom, 660)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 70, height: 27)
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                    
                                    Text("인문학")
                                        .foregroundStyle(Color.sBColor)
                                        .font(.system(size: 15))
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 70, height: 27)
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                    
                                    Text("경제학")
                                        .foregroundStyle(Color.sBColor)
                                        .font(.system(size: 15))
                                }
                            }
                        }
                        .padding(.bottom, 580)
                        .scrollIndicators(.hidden)
                    }
                }
                .refreshable {
                    await viewModel.loadHotPosts()
                    await viewModel.loadAllPosts()
                }
                .task {
                    await viewModel.loadHotPosts()
                    await viewModel.loadAllPosts()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
