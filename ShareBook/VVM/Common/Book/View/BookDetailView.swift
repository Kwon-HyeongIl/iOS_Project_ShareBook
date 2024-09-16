//
//  BookDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI
import Kingfisher

struct BookDetailView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @Bindable var viewModel: BookViewModel
    
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
                    
                    Button {
                        navRouter.navigate(.NewPostUploadPostView(viewModel.book))
                    } label: {
                        HStack {
                            Text("글 작성")
                                .font(.system(size: 18))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 13, height: 13)
                        }
                        .foregroundStyle(Color.SBTitle)
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
                .modifier(TileModifier())
                
            }
            .padding(.bottom)
            
        }
        .modifier(BackModifier())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 10) {
                    Button {
                        Task {
                            viewModel.isBookmark ? await viewModel.unBookmark() : await viewModel.bookmark()
                        }
                    } label: {
                        Image(systemName: viewModel.isBookmark ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14)
                            .foregroundStyle(Color.SBTitle)
                            .padding(.trailing, 4)
                    }
                    
                    Button {
                        navRouter.popToRoot()
                        mainTabCapsule.selectedTab = .house
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                            .foregroundStyle(Color.SBTitle)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                            .foregroundStyle(Color.SBTitle)
                    }
                }
            }
        }
    }
}

#Preview {
    BookDetailView(viewModel: BookViewModel(book: Book.DUMMY_BOOK))
        .environment(NavRouter())
        .environment(MainTabCapsule())
}
