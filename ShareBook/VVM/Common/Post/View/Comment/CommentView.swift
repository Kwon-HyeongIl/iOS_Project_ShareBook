//
//  CommentCellView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(CommentSheetCapsule.self) var commentSheetCapsule: CommentSheetCapsule
    @State private var viewModel: CommentViewModel
    
    @Binding var selectedComment: String
    @Binding var selectedCommentUsername: String
    
    @Binding var isLoadReplies: Bool
    @Binding var isCommentDelete: Bool
    
    @State private var isCommentReplyDelete = false
    
    @State private var isCommentReplyShowing = true
    @State private var isCommentDeleteAlertShowing = false
    
    init(comment: Comment, selectedCommentToReply: Binding<String>, selectedCommentUsername: Binding<String>, isLoadReplies: Binding<Bool>, isCommentDelete: Binding<Bool>) {
        self.viewModel = CommentViewModel(comment: comment)
        
        self._selectedComment = selectedCommentToReply
        self._selectedCommentUsername = selectedCommentUsername
        self._isLoadReplies = isLoadReplies
        self._isCommentDelete = isCommentDelete
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                commentSheetCapsule.isShowing = false
                navRouter.navigate(.ProfileView(viewModel.comment.commentUser, commentSheetCapsule))
            } label: {
                if let profileImageUrl = viewModel.comment.commentUser?.profileImageUrl {
                        KFImage(URL(string: profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                            .padding(.leading, 10)
                            .padding(.top)
                        
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                            .padding(.leading, 10)
                            .padding(.top)
                    }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.comment.commentUser?.username ?? "")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(viewModel.comment.date.relativeTimeString())
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                        .padding(.bottom, 1.5)
                    Spacer()
                    
                    if viewModel.isMyComment {
                        Button {
                            isCommentDeleteAlertShowing = true
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 11, height: 13)
                                .foregroundStyle(.red)
                                .padding(.trailing, 5)
                        }
                        .alert("삭제 하시겠습니까?", isPresented: $isCommentDeleteAlertShowing) {
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("취소")
                            }
                            
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteComment()
                                    isCommentDelete.toggle()
                                }
                            } label: {
                                Text("삭제")
                            }
                        } message: {
                            Text("삭제한 댓글은 다시 복원할 수 없습니다.")
                        }
                    }
                }
                
                Text(viewModel.comment.commentText)
                    .font(.system(size: 12))
                
                if isCommentReplyShowing {
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            selectedComment = viewModel.comment.id
                            selectedCommentUsername = viewModel.comment.commentUser?.username ?? ""
                        }
                    } label: {
                        Text("답글 달기")
                            .font(.system(size: 9))
                            .foregroundStyle(Color.SBTitle)
                            .padding(.leading, 5)
                            .padding(.top, 1)
                    }
                }
                
                if isCommentReplyShowing {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.commentReplies) { commentReply in
                            CommentReplyView(commentReply: commentReply, commentId: viewModel.comment.id, isCommentReplyDelete: $isCommentReplyDelete)
                        }
                    }
                }
                
                HStack {
                    if !isCommentReplyShowing {
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                selectedComment = viewModel.comment.id
                                selectedCommentUsername = viewModel.comment.commentUser?.username ?? ""
                            }
                        } label: {
                            Text("답글 달기")
                                .font(.system(size: 9))
                                .foregroundStyle(Color.SBTitle)
                                .padding(.leading, 5)
                        }
                    }
                    
                    if !viewModel.commentReplies.isEmpty && !isCommentReplyShowing {
                        Button {
                            withAnimation(.smooth(duration: 0.4)) {
                                isCommentReplyShowing = true
                            }
                        } label: {
                            HStack {
                                Text("답글 \(viewModel.comment.commentReplyCount ?? 0)개 더보기")
                                    .font(.system(size: 10))
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10)
                            }
                            .foregroundStyle(Color.SBTitle)
                            .padding(.leading, 10)
                        }
                    }
                }
                .padding(.top, 1)
                .padding(.bottom, 10)
                
                if isCommentReplyShowing && !viewModel.commentReplies.isEmpty {
                    Button {
                        withAnimation(.smooth(duration: 0.4)) {
                            isCommentReplyShowing = false
                        }
                    } label: {
                        HStack {
                            Text("답글 접기")
                                .font(.system(size: 10))
                            
                            Image(systemName: "chevron.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10)
                        }
                        .foregroundStyle(Color.SBTitle)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                    }
                    
                }
            }
            .padding(.leading, 5)
            .padding(.top)
            
            Spacer()
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 10)
        .onChange(of: isLoadReplies) {
            Task {
                await viewModel.loadAllCommentCommentReplies()
            }
            viewModel.comment.commentReplyCount = (viewModel.comment.commentReplyCount ?? 0) + 1
        }
        .onChange(of: isCommentReplyDelete) {
            Task {
                await viewModel.loadAllCommentCommentReplies()
            }
        }
    }
}

#Preview {
    CommentView(comment: Comment.DUMMY_COMMENT, selectedCommentToReply: .constant(UUID().uuidString), selectedCommentUsername: .constant("행이"), isLoadReplies: .constant(false), isCommentDelete: .constant(false))
        .environment(NavRouter())
        .environment(CommentSheetCapsule())
}
