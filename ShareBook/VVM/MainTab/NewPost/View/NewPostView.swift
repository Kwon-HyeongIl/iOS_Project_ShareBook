//
//  SearchView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI

struct NewPostView: View {
    @State private var viewModel = NewPostViewModel()
    
    @State private var searchQuery = ""
    @State private var isShowing = true
    
    var body: some View {
        GradientBackgroundView {
            if isShowing {
                ZStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .opacity(0.3)
                        .frame(width: 300)
                        .shadow(color: .sBColor.opacity(1), radius: 10, x: 5, y: 5)
                    
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
            
            VStack {
                ScrollView {
                    ForEach(viewModel.bookList, id: \.self) { book in
                        BookCoverView(book: book)
                    }
                }
            }
        }
        .searchable(text: $searchQuery, prompt: "등록할 책을 검색하세요")
        .onSubmit(of: .search) {
            isShowing = false
            viewModel.searchBookWithTitle(searchQuery: searchQuery)
        }
    }
}

#Preview {
    NewPostView()
}
