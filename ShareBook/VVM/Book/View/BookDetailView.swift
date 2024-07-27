//
//  BookDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI
import Kingfisher

struct BookDetailView: View {
    @State var viewModel: BookDetailViewModel
    
    init(book: Book) {
        self.viewModel = BookDetailViewModel(book: book)
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                KFImage(URL(string: viewModel.book.image))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray.opacity(0.8), radius: 10, x: 5, y: 5)
                    .padding(.bottom)
                
                VStack {
                    ScrollView {
                        
                    }
                }
                .frame(width: 370, height: 350)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
            }
            
            
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    BookDetailView(book: Book.DUMMY_BOOK)
}
