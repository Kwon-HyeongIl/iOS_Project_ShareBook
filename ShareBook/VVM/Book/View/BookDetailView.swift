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
                HStack {
                    Spacer()
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.white)
                        .padding(.trailing, 3)
                    
                    Button {
                        Task {
                            viewModel.isBookmark ? await viewModel.unbookmark(book: viewModel.book) : await viewModel.bookmark(book: viewModel.book)
                        }
                    } label: {
                        Image(systemName: viewModel.isBookmark ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(viewModel.isBookmark ? Color(red: 112/255, green: 173/255, blue: 179/255) : .white)
                            .padding(.trailing)
                    }
                    
                }
                
                KFImage(URL(string: viewModel.book.image))
                    .resizable()
                    .frame(width: 170, height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .shadow(color: .gray.opacity(0.8), radius: 10, x: 5, y: 5)
                    .padding(.bottom)
                
                VStack {
                    ScrollView {
                        Text("\(viewModel.book.title)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                            .padding(.top, 20)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("\(viewModel.book.author)")
                                .fontWeight(.semibold)
                            Text("지음")
                        }
                        .padding(.top, 15)
                        
                        Text("\(viewModel.book.publisher)")
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        HStack {
                            Text("\(viewModel.book.pubdate)")
                                .fontWeight(.semibold)
                            Text("발행")
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        
                        Divider()
                            .padding(.horizontal, 30)
                        
                        Text("\(viewModel.book.description)")
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                    }
                }
                .frame(width: 370, height: 380)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                .padding(.bottom, 90)
            }
            
            
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    BookDetailView(book: Book.DUMMY_BOOK)
}
