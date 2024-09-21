//
//  BookmarkBooks.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI
import Shimmer

struct BookmarkBookView: View {
    @State private var viewModel = BookmarkBookViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if !viewModel.isRedacted {
                    ForEach(viewModel.books.indices, id: \.self) { index in
                        BookCoverView(book: viewModel.books[index])
                            .padding(.top, index == 0 ? 10 : 0)
                            .padding(.bottom, index == viewModel.books.count-1 ? 20 : 0)
                    }
                } else {
                    ForEach(0..<10, id: \.self) { index in
                        DummyBookCoverView()
                            .padding(.top, index == 0 ? 10 : 0)
                            .padding(.bottom, index == 9 ? 20 : 0)
                    }
                }
            }
        }
        .task {
            Task {
                await viewModel.loadAllBookmarkBooks()
            }
        }
        .task {
            if viewModel.isFirstLoad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        viewModel.isRedacted = false
                    }
                }
                
                viewModel.isFirstLoad = false
            }
        }
    }
}

#Preview {
    BookmarkBookView()
}
