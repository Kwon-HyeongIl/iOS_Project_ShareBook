//
//  BookCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI
import Kingfisher

struct BookCoverView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel: BookViewModel
    
    init(book: Book) {
        self.viewModel = BookViewModel(book: book)
    }
    
    var body: some View {
        Button {
            navRouter.move(.BookDetailView(viewModel))
        } label: {
            BookCoverContentView(book: viewModel.book)
        }
    }
}

#Preview {
    BookCoverView(book: Book.DUMMY_BOOK)
        .environment(NavRouter())
}
