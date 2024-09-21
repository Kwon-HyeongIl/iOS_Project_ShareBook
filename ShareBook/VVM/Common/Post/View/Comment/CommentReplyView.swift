//
//  CommentReplyView.swift
//  ShareBook
//
//  Created by 권형일 on 8/19/24.
//

import SwiftUI
import Kingfisher

struct CommentReplyView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(CommentSheetCapsule.self) var commentSheetCapsule: CommentSheetCapsule
    @State private var viewModel: CommentReplyViewModel
    
    @Binding var isCommentReplyDelete: Bool
    @State private var isCommentDeleteAlertShowing = false
    
    init(commentReply: Comment, commentId: String, isCommentReplyDelete: Binding<Bool>) {
        self.viewModel = CommentReplyViewModel(commentReply: commentReply, commentId: commentId)
        self._isCommentReplyDelete = isCommentReplyDelete
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                commentSheetCapsule.isShowing = false
                navRouter.navigate(.ProfileView(viewModel.commentReply.commentUser?.id ?? "", commentSheetCapsule))
            } label: {
                if let profileImageUrl = viewModel.commentReply.commentUser?.profileImageUrl {
                        KFImage(URL(string: profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                        
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                    }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.commentReply.commentUser?.username ?? "")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(viewModel.commentReply.date.relativeTimeString())
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                        .padding(.bottom, 1.5)
                    
                    Spacer()
                    
                    if viewModel.isMyCommentReply {
                        Button {
                            isCommentDeleteAlertShowing = true
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 11, height: 13)
                                .foregroundStyle(.red)
                        }
                        .alert("삭제 하시겠습니까?", isPresented: $isCommentDeleteAlertShowing) {
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("취소")
                            }
                            
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteCommentReply()
                                    isCommentReplyDelete.toggle()
                                }
                            } label: {
                                Text("삭제")
                            }
                        } message: {
                            Text("삭제한 댓글은 다시 복원할 수 없습니다.")
                        }
                    }
                }
                
                Text(viewModel.commentReply.commentText)
                    .font(.system(size: 12))
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    CommentReplyView(commentReply: Comment.DUMMY_COMMENT, commentId: "", isCommentReplyDelete: .constant(false))
        .environment(NavRouter())
        .environment(CommentSheetCapsule())
}
