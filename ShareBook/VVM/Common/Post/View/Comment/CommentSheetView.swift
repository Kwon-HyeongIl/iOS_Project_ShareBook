//
//  CommentListView.swift
//  ShareBook
//
//  Created by 권형일 on 8/20/24.
//

import SwiftUI
import Kingfisher
import Shimmer

struct CommentSheetView: View {
    @State private var viewModel: CommentSheetViewModel
    
    @State private var selectedCommentId = ""
    @State private var selectedCommentUsername = ""
    
    @State private var isLoadReplies = false
    @State private var isRedacted = false
    @State private var isProgressive = false
    
    @State private var isCommentDelete = false
    
    init(post: Post) {
        self.viewModel = CommentSheetViewModel(post: post)
    }
    
    var body: some View {
        GradientBackgroundView {
            ZStack {
                VStack(spacing: 0) {
                    Text("댓글")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 15)
                        .padding(.top, 30)
                    
                    Divider()
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 5) {
                            ForEach(viewModel.comments.indices, id: \.self) { index in
                                CommentView(comment: viewModel.comments[index], selectedCommentToReply: $selectedCommentId, selectedCommentUsername: $selectedCommentUsername, isLoadReplies: $isLoadReplies, isCommentDelete: $isCommentDelete)
                                    .padding(.top, index == 0 ? 10 : 0)
                                    .redacted(reason: isRedacted ? .placeholder : [])
                                    .shimmering(active: isRedacted ? true : false, bandSize: 0.4)
                            }
                        }
                    }
                    .blur(radius: isProgressive ? 1 : 0)
                    
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
                                        Text("취소")
                                            .font(.system(size: 11))
                                            .foregroundStyle(.red)
                                            .opacity(0.6)
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
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        isProgressive = true
                                    }
                                    
                                    
                                    await viewModel.uploadComment()
                                    await viewModel.loadAllUserComment()
                                    
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isProgressive = false
                                    }
                                    
                                } else { // 답글 작성
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        isProgressive = true
                                    }
                                    
                                    await viewModel.uploadCommentReply(upperCommentId: selectedCommentId)
                                    
                                    selectedCommentId = ""
                                    selectedCommentUsername = ""
                                    
                                    isLoadReplies.toggle()
                                    
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isProgressive = false
                                    }
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
                
                if isProgressive {
                    ProgressView()
                }
            }
        }
        .onChange(of: isCommentDelete) {
            Task {
                await viewModel.loadAllUserComment()
            }
        }
        .task {
            isRedacted = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.4)) {
                    isRedacted = false
                }
            }
        }
    }
}

#Preview {
    CommentSheetView(post: Post.DUMMY_POST)
}
