//
//  SearchView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI
import Shimmer

struct NewPostView: View {
    @State private var viewModel = NewPostViewModel()
    
    @State private var searchText = ""
    @State private var isShowing = true
    
    @State private var isRedacted = false
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                VStack {
                    if isShowing {
                        ZStack {
                            Image("ShareBook_TextLogo")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Rectangle())
                                .opacity(0.3)
                                .frame(width: 300)
                                .shadow(color: .SBTitle.opacity(1), radius: 10, x: 5, y: 5)
                                .padding(.top, 30)
                            
                            ZStack {
                                Girl3DView()
                                
                                Image(systemName: "bubble.middle.bottom.fill")
                                    .resizable()
                                    .frame(width: 260, height: 100)
                                    .foregroundStyle(.white.opacity(0.4))
                                    .overlay {
                                        Text("오늘은 어떤 가치를 발견 하셨나요?")
                                            .font(.system(size: 15))
                                            .modifier(ItalicFontModifier())
                                            .padding(.bottom)
                                    }
                                    .padding(.bottom, 350)
                            }
                            .padding(.top, 80)
                        }
                    }
                    
                    ScrollView {
                        LazyVStack {
                            if !isRedacted {
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
            }
            .toolbar {
                ToolbarItem {
                    HStack(alignment: .center) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundStyle(Color.SBTitle)
                            .opacity(0.8)
                            .padding(.leading, 10)
                        
                        TextField("등록할 책을 검색하세요", text: $searchText)
                            .font(.system(size: 15))
                            .submitLabel(.search)
                            .onSubmit {
                                Task {
                                    isShowing = false
                                    viewModel.searchBookWithTitle(searchQuery: searchText)
                                    
                                    isRedacted = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation(.easeOut(duration: 0.4)) {
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
                    .frame(width: max(0, proxy.size.width - 30))
                    .padding(.top, 5)
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
    }
}

#Preview {
    NewPostView()
}
