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
    
    @State private var isRedacted = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.books.indices, id: \.self) { index in
                    BookCoverView(book: viewModel.books[index])
                        .padding(.top, index == 0 ? 10 : 0)
                        .padding(.bottom, index == viewModel.books.count-1 ? 20 : 0)
                        .redacted(reason: isRedacted ? .placeholder : [])
                        .shimmering(active: isRedacted ? true : false, bandSize: 0.4)
                }
            }
        }
        .task {
            Task {
                await viewModel.loadAllBookmarkBooks()
                
                isRedacted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        isRedacted = false
                    }
                }
            }
        }
    }
}

#Preview {
    BookmarkBookView()
}
