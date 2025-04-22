//
//  BookCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI
import Kingfisher

struct BookCoverView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @State private var viewModel: BookViewModel
    
    init(book: Book) {
        self.viewModel = BookViewModel(book: book)
    }
    
    var body: some View {
        Button {
            navRouter.navigate(.BookDetailView(viewModel))
        } label: {
            BookCoverContentView(book: viewModel.book)
        }
    }
}

#Preview {
    BookCoverView(book: Book.DUMMY_BOOK)
        .environment(NavigationRouter())
}
