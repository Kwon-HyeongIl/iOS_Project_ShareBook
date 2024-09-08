//
//  CommentListView.swift
//  ShareBook
//
//  Created by 권형일 on 8/20/24.
//

import SwiftUI
import Kingfisher

struct CommentListView: View {
    @State private var viewModel: CommentListViewModel
    
    @State private var selectedCommentId = ""
    @State private var selectedCommentUsername = ""
    
    @State private var isLoadReplies = false
    
    init(post: Post) {
        self.viewModel = CommentListViewModel(post: post)
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
                            CommentView(comment: comment, selectedCommentToReply: $selectedCommentId, selectedCommentUsername: $selectedCommentUsername, isLoadReplies: $isLoadReplies)
                        }
                    }
                }
                
                Divider()
                
                HStack(alignment: .bottom) {
                    if let profileImageUrl = viewModel.currentUser?.profileImageUrl {
                        KFImage(URL(string: profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                            .padding(.bottom, 2)
                        
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                            .padding(.bottom, 2)
                    }
                    
                    VStack {
                        if !selectedCommentId.isEmpty {
                            HStack(spacing: 0) {
                                Text("\(selectedCommentUsername)님의 댓글")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 25)
                                
                                Button {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        selectedCommentId = ""
                                        selectedCommentUsername = ""
                                    }
                                } label: {
                                    HStack(spacing: 0) {
                                        Text("취소")
                                            .font(.system(size: 11))
                                            .foregroundStyle(Color.SBTitle)
                                            .padding(.trailing, 5)
                                        
                                        Image(systemName: "trash")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .foregroundStyle(Color.SBTitle)
                                    }
                                }
                                
                                Spacer()
                            }
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.trailing)
                        }
                        
                        TextField(selectedCommentId.isEmpty ? "댓글을 작성하세요" : "답글을 작성하세요", text: $viewModel.commentText, axis: .vertical)
                            .font(.system(size: 14))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                                    .opacity(0.5)
                            }
                            .padding(.horizontal, 5)
                    }
                    
                    Button {
                        Task {
                            if selectedCommentId.isEmpty { // 댓글 작성
                                await viewModel.uploadComment()
                                await viewModel.loadAllUserComment()
                                
                            } else { // 답글 작성
                                await viewModel.uploadCommentReply(upperCommentId: selectedCommentId)
                                
                                selectedCommentId = ""
                                selectedCommentUsername = ""
                                
                                isLoadReplies.toggle()
                            }
                            viewModel.commentText = ""
                        }
                    } label: {
                        Text("작성")
                            .foregroundStyle(Color.SBTitle)
                            .font(.system(size: 16))
                            .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top, selectedCommentId.isEmpty ? 9 : 8)
            }
        }
    }
}

#Preview {
    CommentListView(post: Post.DUMMY_POST)
}
