//
//  SearchView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI

struct NewPostView: View {
    @State var viewModel = NewPostViewModel()
    @State var searchQuery = ""
    @State var isShowing = true
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        GradientBackgroundView {
            if isShowing {
                VStack {
                    ScatteredBook3DView()
                    
                    VStack(spacing: 10) {
                        Text("\"내가 세계를 알게 된 것은 책에 의해서였다\"")
                            .modifier(ItalicFontModifier())
                            .multilineTextAlignment(.center)
                        Text("- 사르트르")
                            .modifier(ItalicFontModifier())
                            .opacity(0.5)
                    }
                    .padding()
                    .padding(.vertical)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                    .padding(.horizontal)
                }
                .padding(.bottom, 100)
            }
            
            ScrollView {
                ForEach(viewModel.bookList, id: \.self) { book in
                    NewPostBookCoverView(book: book, selectedTab: $selectedTab)
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
    NewPostView(selectedTab: .constant(.plusSquareOnSquare ))
}
