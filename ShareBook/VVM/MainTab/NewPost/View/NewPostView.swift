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
    
    @State private var isBookCoverRedacted = false
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                if isShowing {
                    ZStack {
                        Image("ShareBook_TextLogo")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Rectangle())
                            .opacity(0.6)
                            .frame(width: 300)
                            .shadow(color: .sBColor.opacity(1), radius: 10, x: 5, y: 5)
                            .shimmering(animation: .easeInOut(duration: 3).repeatCount(.max, autoreverses: false).delay(0))
                        
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
                    }
                }

                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.bookList, id: \.self) { book in
                            BookCoverView(book: book)
                                .redacted(reason: isBookCoverRedacted ? .placeholder : [])
                                .shimmering(active: isBookCoverRedacted ? true : false, bandSize: 0.4)
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundStyle(Color.sBColor)
                            .opacity(0.8)
                            .padding(.leading, 10)
                        
                        TextField("등록할 책을 검색하세요", text: $searchText)
                            .font(.system(size: 15))
                            .submitLabel(.search)
                            .onSubmit {
                                Task {
                                    isShowing = false
                                    viewModel.searchBookWithTitle(searchQuery: searchText)
                                    
                                    isBookCoverRedacted = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation(.easeOut(duration: 0.4)) {
                                            isBookCoverRedacted = false
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
                    .frame(width: max(0, proxy.size.width - 50))
                    .padding(.bottom, 10)
                    .padding(.top, 5)
                }
            }
        }
    }
}

#Preview {
    NewPostView()
}
