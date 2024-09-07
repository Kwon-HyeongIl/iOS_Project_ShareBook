//
//  PostSearchView.swift
//  ShareBook
//
//  Created by 권형일 on 9/7/24.
//

import SwiftUI
import Shimmer

struct PostSearchView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel = PostSearchViewModel()
    
    @State private var searchText = ""
    @State private var isGenreRedacted = true
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: viewModel.columns, spacing: viewModel.resizePost(proxyWidth: proxy.size.width)) {
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
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button {
                            navStackControlTower.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(Color.sBColor)
                                .opacity(0.8)
                                .padding(.leading, 10)
                            
                            TextField("관심있는 책을 검색하세요", text: $searchText)
                                .font(.system(size: 15))
                                .submitLabel(.search)
                                .onSubmit {
                                    Task {
                                        await viewModel.searchPostByBookName(searchText: searchText)
                                        
                                        isGenreRedacted = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            withAnimation(.easeOut(duration: 0.4)) {
                                                isGenreRedacted = false
                                            }
                                        }
                                    }
                                }
                            
                        }
                        .frame(height: 38)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.sBColor, lineWidth: 1)
                        }
                    }
                    .frame(width: max(0, proxy.size.width - 35))
                }
            }
        }
    }
}

#Preview {
    PostSearchView()
        .environment(NavStackControlTower())
}
