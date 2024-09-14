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
                                
                                Text(notification.date.relativeTimeString())
                                    .font(.system(size: 10))
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 5)
                            }
                            .padding(.leading, 5)
                            Spacer()
                        }
                        .frame(height: 70)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Button {
                        navRouter.back()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                    }
                    
                    Text("알림")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
        .environment(NavRouter())
}
