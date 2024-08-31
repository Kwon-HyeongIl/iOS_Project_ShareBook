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
                VStack {
                    ScatteredBook3DView()
                    
                    VStack(spacing: 10) {
                        Text("오늘은 어떤 가치를 발견하셨나요?")
                            .modifier(ItalicFontModifier())
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 30)
                    .modifier(TileModifier())
                }
                .padding(.bottom, 100)
            }
            
            ScrollView {
                ForEach(viewModel.bookList, id: \.self) { book in
                    BookCoverView(book: book)
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
