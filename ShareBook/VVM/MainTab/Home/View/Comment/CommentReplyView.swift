//
//  CommentReplyView.swift
//  ShareBook
//
//  Created by 권형일 on 8/19/24.
//

import SwiftUI
import Kingfisher

struct CommentReplyView: View {
    let commentReply: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            if let profileImageUrl = commentReply.commentUser?.profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.top)
                    
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.top, 5)
                }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(commentReply.commentUser?.username ?? "")
                        .font(.system(size: 13))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(commentReply.date.relativeTimeString())
                        .font(.system(size: 11))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                }
                
                Text(commentReply.commentText)
                    .font(.system(size: 13))
            }
        }
        .padding(.trailing)
        .padding(.vertical)
    }
}

#Preview {
    CommentReplyView(commentReply: Comment.DUMMY_COMMENT)
}
