//
//  NewPostBookDetailVIew.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI
import Kingfisher

struct NewPostBookDetailView: View {
    @Bindable var viewModel: NewPostBookViewModel
    
    @Binding var stackActive: Bool
    @Binding var selectedTab: Tab
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                ZStack {
                    HStack {
                        KFImage(URL(string: viewModel.book.image))
                            .resizable()
                            .frame(width: 170, height: 230, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .shadow(color: .gray.opacity(0.8), radius: 10, x: 5, y: 5)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink {
                        NewPostUploadPostView(book: viewModel.book, stackActive: $stackActive, selectedTab: $selectedTab)
                    } label: {
                        HStack {
                            Text("글 작성")
                                .font(.system(size: 18))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 13, height: 13)
                        }
                        .foregroundStyle(.blue)
                        .padding(.leading, 280)
                        .padding(.top, 195)
                    }
                }
                
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
                .frame(maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                
            }
            .padding(.bottom)
            
        }
        .modifier(BackButtonModifier())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.sBColor)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        viewModel.isBookmark ? await viewModel.unbookmark() : await viewModel.bookmark()
                    }
                } label: {
                    Image(systemName: viewModel.isBookmark ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.sBColor)
                        .padding(.trailing, 5)
                }
            }
        }
    }
}

#Preview {
    NewPostBookDetailView(viewModel: NewPostBookViewModel(book: Book.DUMMY_BOOK), stackActive: .constant(true), selectedTab: .constant(.plusSquareOnSquare))
}
