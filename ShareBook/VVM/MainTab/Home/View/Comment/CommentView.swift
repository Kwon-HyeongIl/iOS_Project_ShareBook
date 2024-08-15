//
//  CommentView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("댓글")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 15)
                    .padding(.top, 30)
                
                Divider()
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.comments) { comment in
                            CommentCellView(comment: comment)
                        }
                    }
                }
                
                Divider()
                
                HStack {
                    if let profileImageUrl = viewModel.currentUser?.profileImageUrl {
                        KFImage(URL(string: profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                    
                    TextField("댓글 작성", text: $viewModel.commentText, axis: .vertical)
                        .padding(.leading, 5)
                    
                    Button {
                        Task {
                            await viewModel.uploadComment()
                            await viewModel.loadAllUserComment()
                        }
                    } label: {
                        Text("작성")
                            .foregroundStyle(Color.sBColor)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
