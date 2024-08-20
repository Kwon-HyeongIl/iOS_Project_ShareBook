//
//  CommentCellView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State private var viewModel: CommentViewModel
    
    @Binding var selectedComment: String
    @Binding var selectedCommentUsername: String
    
    @Binding var isLoadReplies: Bool
    
    @State private var isCommentReplyShowing = false
    
    init(comment: Comment, selectedCommentToReply: Binding<String>, selectedCommentUsername: Binding<String>, isLoadReplies: Binding<Bool>) {
        self.viewModel = CommentViewModel(comment: comment)
        
        self._selectedComment = selectedCommentToReply
        self._selectedCommentUsername = selectedCommentUsername
        self._isLoadReplies = isLoadReplies
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if let profileImageUrl = viewModel.comment.commentUser?.profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.leading)
                        .padding(.top)
                    
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.leading)
                        .padding(.top)
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
                }
                
                Text(viewModel.comment.commentText)
                    .font(.system(size: 12))
                
                if isCommentReplyShowing {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.commentReplies) { commentReply in
                            CommentReplyView(commentReply: commentReply)
                                
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
                                .foregroundStyle(Color.sBColor)
                                .padding(.leading, 5)
                        }
                    }
                    
                    if !viewModel.commentReplies.isEmpty && !isCommentReplyShowing {
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
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
                            .foregroundStyle(Color.sBColor)
                            .padding(.leading, 10)
                            
                        }
                    }
                }
                .padding(.top, 1)
                
                if isCommentReplyShowing {
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
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
                        .foregroundStyle(Color.sBColor)
                        .padding(.leading, 20)
                    }
                    
                }
            }
            .padding(.leading, 5)
            .padding(.vertical)
            
            Spacer()
        }
        .padding(.trailing)
        .onChange(of: isLoadReplies) {
            Task {
                await viewModel.loadAllCommentCommentReplies()
            }
        }
    }
}

#Preview {
    CommentView(comment: Comment.DUMMY_COMMENT, selectedCommentToReply: .constant(UUID().uuidString), selectedCommentUsername: .constant("행이"), isLoadReplies: .constant(false))
}
