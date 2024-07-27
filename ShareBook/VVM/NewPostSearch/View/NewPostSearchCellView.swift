//
//  SearchCellView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI
import Kingfisher

struct NewPostSearchCellView: View {
    @State var viewModel: NewPostSearchCellViewModel
    
    init(book: Book) {
        self.viewModel = NewPostSearchCellViewModel(book: book)
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                BookDetailView(book: viewModel.book)
            } label: {
                HStack {
                    KFImage(URL(string: viewModel.book.image))
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("\(viewModel.book.title)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text("\(viewModel.book.author)")
                        
                        Text("\(viewModel.book.pubdate)")
                            .foregroundStyle(.gray)
                    }
                    .padding(.trailing, 50)
                }
                .frame(width: 370, height: 170)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
            }
            .tint(.black)
        }
    }
}

#Preview {
    NewPostSearchCellView(book: Book.DUMMY_BOOK)
}
