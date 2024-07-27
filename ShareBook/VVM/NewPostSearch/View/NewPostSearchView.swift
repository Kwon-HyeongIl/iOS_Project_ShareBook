//
//  SearchView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI

struct NewPostSearchView: View {
    @State var viewModel = NewPostSearchViewModel()
    @State var searchQuery = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.bookList, id: \.self) { book in
                    NewPostSearchCellView(book: book)
                }
            }
        }
        .searchable(text: $searchQuery, prompt: "등록할 책을 검색하세요")
        .onChange(of: searchQuery) { oldValue, newValue in
            viewModel.searchBookWithTitle(searchQuery: searchQuery)
        }
    }
}

#Preview {
    NewPostSearchView()
}
