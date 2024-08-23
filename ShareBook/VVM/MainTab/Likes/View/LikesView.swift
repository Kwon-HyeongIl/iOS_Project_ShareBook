//
//  MyPostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct LikesView: View {
    @State var viewModel = LikesViewModel()
    
    @State private var selectedGenre = Genre.all
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("내가 작성한 글")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Genre.allCases.indices, id: \.self) { index in
                            Button {
                                Task {
                                    await viewModel.loadSpecificGenrePosts(genre: Genre.allCases[index])
                                }
                                selectedGenre = Genre.allCases[index]
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 27)
                                        .foregroundStyle(selectedGenre == Genre.allCases[index] ? Color.sBColor : .white)
                                        .opacity(0.5)
                                    
                                    Text("\(Genre.allCases[index].rawValue)")
                                        .foregroundStyle(selectedGenre == Genre.allCases[index] ? .white : .black)
                                        .font(.system(size: 13))
                                        .opacity(selectedGenre == Genre.allCases[index] ? 1.0 : 0.6)
                                        .padding(.horizontal)
                                }
                                .padding(.leading, index == 0 ? 15 : 0)
                                .padding(.trailing, index == Genre.allCases.count - 1 ? 15 : 0)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.posts) { post in
                            LikesPostCoverView(post: post)
                        }
                    }
                }
            }
            .task {
                Task {
                    if selectedGenre == Genre.all {
                        await viewModel.loadAllMyPosts()
                    } else {
                        await viewModel.loadSpecificGenrePosts(genre: selectedGenre)
                    }
                }
            }
        }
    }
}

#Preview {
    LikesView()
}
