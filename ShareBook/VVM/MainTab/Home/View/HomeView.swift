//
//  PostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI
import Kingfisher
import Shimmer

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    @State private var selectedGenre = Genre.all
    @State private var isHotRedacted = true
    @State private var isGenreRedacted = true
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { proxy in
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
                                LazyHStack(spacing: 20) {
                                    ForEach(viewModel.hotPosts.indices, id: \.self) { index in
                                        PostCoverView(post: viewModel.hotPosts[index], isHotPost: true)
                                            .padding(.leading, index == 0 ? 15 : 0)
                                            .padding(.trailing, index == viewModel.hotPosts.count - 1 ? 15 : 0)
                                            .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                                view
                                                    .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                            }
                                            .redacted(reason: isHotRedacted ? .placeholder : [])
                                            .shimmering(active: isHotRedacted ? true : false, bandSize: 0.4)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            
                            HStack {
                                Text("금주의 인기 구절")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                    .padding(.leading, 20)
                                    .padding(.top)
                            }
                            .padding(.bottom, 380)
                            
                            Divider()
                                .padding(.horizontal)
                                .padding(.top, 380)
                        }
                        
                        ZStack {
                            VStack {
                                LazyVGrid(columns: columns, spacing: viewModel.calSizeBase26And393(proxyWidth: proxy.size.width)) {
                                    ForEach(viewModel.posts) { post in
                                        PostCoverView(post: post)
                                            .redacted(reason: isGenreRedacted ? .placeholder : [])
                                            .shimmering(active: isGenreRedacted ? true : false, bandSize: 0.4)
                                    }
                                }
                                .padding(.top, 90)
                                .padding(.horizontal, 5)
                                
                                Spacer()
                            }
                            
                            Text("모든 구절")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                .padding(.leading, 20)
                                .padding(.bottom, 660)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(Genre.allCases.indices, id: \.self) { index in
                                        Button {
                                            Task {
                                                await viewModel.loadSpecificGenrePosts(genre: Genre.allCases[index])
                                            }
                                            selectedGenre = Genre.allCases[index]
                                            
                                            isGenreRedacted = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                isGenreRedacted = false
                                            }
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(height: 27)
                                                    .foregroundStyle(selectedGenre == Genre.allCases[index] ? Color.sBColor : .white)
                                                    .opacity(0.5)
                                                
                                                Text("\(Genre.allCases[index].rawValue)")
                                                    .foregroundStyle(selectedGenre == Genre.allCases[index] ? .white : .black)
                                                    .font(.system(size: 13))
                                                    .opacity(selectedGenre == Genre.allCases[index] ? 1.0 : 0.6)
                                                    .padding(.horizontal)
                                            }
                                            .padding(.leading, index == 0 ? 15 : 0)
                                            .padding(.trailing, index == Genre.allCases.count - 1 ? 15 : 0)
                                        }
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.smooth(duration: 0.4)) {
                        self.isHotRedacted = false
                        self.isGenreRedacted = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(NavStackControlTower())
}
