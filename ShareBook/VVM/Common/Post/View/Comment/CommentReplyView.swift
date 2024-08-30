//
//  CommentReplyView.swift
//  ShareBook
//
//  Created by 권형일 on 8/19/24.
//

import SwiftUI
import Kingfisher

struct CommentReplyView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    let commentReply: Comment
    
    @Binding var isCommentSheetShowing: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                isCommentSheetShowing = false
                navStackControlTower.push(.ProfileView(commentReply.commentUser))
            } label: {
                if let profileImageUrl = commentReply.commentUser?.profileImageUrl {
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
                    Text(commentReply.commentUser?.username ?? "")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(commentReply.date.relativeTimeString())
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                        .padding(.bottom, 1.5)
                }
                
                Text(commentReply.commentText)
                    .font(.system(size: 12))
            }
        }
        .padding(.trailing)
        .padding(.vertical, 5)
    }
}

#Preview {
    CommentReplyView(commentReply: Comment.DUMMY_COMMENT, isCommentSheetShowing: .constant(false))
        .environment(NavStackControlTower())
}
