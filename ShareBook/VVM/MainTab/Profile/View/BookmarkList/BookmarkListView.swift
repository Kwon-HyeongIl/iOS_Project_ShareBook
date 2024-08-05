//
//  BookmarkListView.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI

struct BookmarkListView: View {
    @State var viewModel = BookmarkListViewModel()
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("북마크한 책")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ScrollView {
                    ForEach(viewModel.bookList, id: \.self) { book in
                        BookCoverView(book: book)
                    }
                }
            }
        }
    }
}

#Preview {
    BookmarkListView()
}
