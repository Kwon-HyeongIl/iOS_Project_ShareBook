//
//  HomeBookCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct HomeBookCoverView: View {
    @State var viewModel: HomeBookViewModel
    
    init(book: Book) {
        self.viewModel = HomeBookViewModel(book: book)
    }
    
    var body: some View {
        NavigationLink {
            HomeBookDetailView(viewModel: viewModel)
        } label: {
            HStack {
                KFImage(URL(string: viewModel.book.image))
                    .resizable()
                    .frame(width: 90, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .padding(.leading)
                Spacer()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(viewModel.book.title)")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .truncationMode(.tail)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(viewModel.book.author)")
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .leading)
                    
                    Text("\(viewModel.book.pubdate)")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.trailing, 10)
            }
            .frame(height: 160)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
        }
    }
}


#Preview {
    HomeBookCoverView(book: Book.DUMMY_BOOK)
}