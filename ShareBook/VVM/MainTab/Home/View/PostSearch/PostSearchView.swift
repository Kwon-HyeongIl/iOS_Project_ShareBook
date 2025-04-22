//
//  PostSearchView.swift
//  ShareBook
//
//  Created by 권형일 on 9/7/24.
//

import SwiftUI
import Shimmer

struct PostSearchView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @State private var viewModel = PostSearchViewModel()
    
    @State private var searchText = ""
    @State private var isRedacted = false
    
    @FocusState private var focus: PostSearchFocusField?
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: viewModel.columns, spacing: viewModel.postSpacing(proxyWidth: proxy.size.width)) {
                            if !isRedacted {
                                ForEach(viewModel.posts) { post in
                                    PostCoverView(post: post)
                                }
                            } else {
                                ForEach(0..<12) { _ in
                                    DummyPostCoverView(isHotPost: false)
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 5)
                }
            }
            .onAppear {
                focus = .main
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button {
                            navRouter.back()
                        } label: {
                            Image(systemName: "chevron.left")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(Color.SBTitle)
                                .opacity(0.8)
                                .padding(.leading, 10)
                            
                            TextField("관심있는 책을 검색하세요", text: $searchText)
                                .font(.system(size: 15))
                                .submitLabel(.search)
                                .focused($focus, equals: .main)
                                .onSubmit {
                                    Task {
                                        await viewModel.searchPostByBookName(searchText: searchText)
                                        
                                        isRedacted = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            withAnimation {
                                                isRedacted = false
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
                                .stroke(Color.SBTitle, lineWidth: 1)
                        }
                    }
                    .frame(width: max(0, proxy.size.width - 25))
                    .padding(.bottom, 10)
                    .padding(.top, 5)
                }
            }
        }
    }
}

#Preview {
    PostSearchView()
        .environment(NavigationRouter())
}
