//
//  BookmarkBooks.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct BookmarkBooksView: View {
    @State private var viewModel = BookmarkBooksViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.books.indices, id: \.self) { index in
                    BookCoverView(book: viewModel.books[index])
                        .padding(.top, index == 0 ? 10 : 0)
                        .padding(.bottom, index == viewModel.books.count-1 ? 20 : 0)
                }
            }
        }
        .task {
            Task {
                await viewModel.loadAllBookmarkBooks()
            }
        }
    }
}

#Preview {
    BookmarkBooksView()
}
