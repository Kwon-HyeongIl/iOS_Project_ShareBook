//
//  CommentCellView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            if let profileImageUrl = comment.commentUser?.profileImageUrl {
                KFImage(URL(string: profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                    .padding(.leading)
                
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                    .padding(.leading)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(comment.commentUser?.username ?? "")
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(comment.date.relativeTimeString())
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                }
                
                Text(comment.commentText)
                    .font(.system(size: 14))
            }
            .padding(.leading, 5)
            .padding(.vertical)
            
            Spacer()
        }
    }
}

#Preview {
    CommentCellView(comment: Comment.DUMMY_COMMENT)
}
