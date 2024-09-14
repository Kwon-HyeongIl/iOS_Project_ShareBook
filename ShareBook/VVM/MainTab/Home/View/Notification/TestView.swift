//
//  TestView.swift
//  ShareBook
//
//  Created by 권형일 on 9/14/24.
//

import SwiftUI

struct TestView: View {
    var notification = Notification(id: "sdf", type: .comment, data: "df", title: "새 댓글", body: "댓글내용", date: Date())
    
    var body: some View {
        HStack {
            switch notification.type {
            case .comment:
                Image(systemName: "bubble.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(Color.SBTitle)
            case .follow:
                Image(systemName: "person.2.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(Color.SBTitle)
            case .like:
                Image(systemName: "heart.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(Color.SBTitle)
            }
            
            VStack(spacing: 2) {
                Text(notification.title)
                    .font(.system(size: 16))
                
                Text(notification.body)
                    .font(.system(size: 13))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                
                Text(notification.date.relativeTimeString())
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
                    .padding(.trailing)
            }
            .padding(.leading, 5)
            Spacer()
        }
        .frame(height: 70)
        .padding(.horizontal)
    }
}

#Preview {
    TestView()
}
