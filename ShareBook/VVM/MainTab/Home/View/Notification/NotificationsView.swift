//
//  NotificationsView.swift
//  ShareBook
//
//  Created by 권형일 on 9/14/24.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel = NotificationsViewModel()
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.notifications) { notification in
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
                            
                            VStack(alignment:.leading, spacing: 2) {
                                Text(notification.title)
                                    .font(.system(size: 14))
                                
                                Text(notification.body)
                                    .font(.system(size: 12))
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .multilineTextAlignment(.leading)
                                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                    .padding(.leading, 1)
                                
                                Text(notification.date.relativeTimeString())
                                    .font(.system(size: 10))
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 3)
                            }
                            .padding(.leading, 5)
                            Spacer()
                        }
                        .frame(height: 70)
                        .padding(.horizontal)
                        .onTapGesture {
                            if notification.type == NotificationType.comment || notification.type == NotificationType.like {
                                Task {
                                    guard let post = await viewModel.loadSpecificPost(postId: notification.data) else { return }
                                    
                                    @State var postViewModel = PostViewModel(post: post)
                                    @State var commentSheetCapsule = CommentSheetCapsule()
                                    
                                    if notification.type == NotificationType.comment {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            commentSheetCapsule.isShowing = true
                                        }
                                    }
                                    navRouter.navigate(.PostDetailView(postViewModel, commentSheetCapsule))
                                }
                                
                            } else if notification.type == NotificationType.follow {
                                Task {
                                    let user = await AuthManager.shared.loadSpecificUser(userId: notification.data)
                                    navRouter.navigate(.ProfileView(user?.id ?? "", nil))
                                }
                            }
                        }
                    }
                }
            }
        }
        .modifier(BackTitleModifier(navigationTitle: "알림"))
    }
}

#Preview {
    NotificationsView()
        .environment(NavRouter())
}
