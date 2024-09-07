//
//  BookCoverContentView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI
import Kingfisher

struct BookCoverContentView: View {
    let book: Book
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: book.image))
                    .resizable()
                    .frame(width: 90, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .padding(.leading)
                Spacer()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(book.title)")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .truncationMode(.tail)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(book.author)")
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .leading)
                    
                    Text("\(book.pubdate)")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 10)
            }
            .frame(height: 160)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
        }
        
    }
}

#Preview {
    BookCoverContentView(book: Book.DUMMY_BOOK)
}
