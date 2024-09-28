//
//  NewPostSearchView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI

struct SearchBookView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel = SearchBookViewModel()
    
    @FocusState private var focus: BookSearchFocusField?
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    LazyVStack {
                        if !viewModel.isRedacted {
                            ForEach(viewModel.bookList, id: \.self) { book in
                                BookCoverView(book: book)
                            }
                        } else {
                            ForEach(0..<12) { _ in
                                DummyBookCoverView()
                            }
                        }
                    }
                    .padding(.top, 5)
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
                        
                        HStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(Color.SBTitle)
                                .opacity(0.8)
                                .padding(.leading, 10)
                            
                            TextField("등록할 책을 검색하세요", text: $viewModel.searchText)
                                .font(.system(size: 15))
                                .submitLabel(.search)
                                .focused($focus, equals: .main)
                                .onSubmit {
                                    Task {
                                        viewModel.isShowing = false
                                        viewModel.searchBookWithTitle(searchQuery: viewModel.searchText)
                                        
                                        viewModel.isRedacted = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            withAnimation(.easeOut(duration: 0.4)) {
                                                viewModel.isRedacted = false
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
    SearchBookView()
}
