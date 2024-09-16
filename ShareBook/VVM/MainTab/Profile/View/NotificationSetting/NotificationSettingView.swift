//
//  NotificationSettingView.swift
//  ShareBook
//
//  Created by 권형일 on 9/15/24.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel = NotificationSettingViewModel()
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Toggle("댓글", isOn: $viewModel.commentNotification)
                        .font(.system(size: 18))
                        .tint(.SBTitle)
                        .padding(.horizontal)
                    Text(viewModel.commentNotification ? "다른 사용자가 여러분의 글에 댓글을 작성하면 앱을 종료한 상태에서도 알림을 받을 수 있어요" : "앱을 종료한 상태에서는 알림이 울리지 않지만 앱 내의 알림창에서는 확인할 수 있어요")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    Divider()
                        .padding(.horizontal)
                    
                    
                    Toggle("좋아요", isOn: $viewModel.likeNotification)
                        .font(.system(size: 18))
                        .tint(.SBTitle)
                        .padding(.horizontal)
                    Text(viewModel.likeNotification ? "다른 사용자가 여러분의 글에 좋아요를 누르면 앱을 종료한 상태에서도 알림을 받을 수 있어요" : "앱을 종료한 상태에서는 알림이 울리지 않지만 앱 내의 알림창에서는 확인할 수 있어요")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    Divider()
                        .padding(.horizontal)
                    
                    
                    Toggle("팔로우", isOn: $viewModel.followNotification)
                        .font(.system(size: 18))
                        .tint(.SBTitle)
                        .padding(.horizontal)
                    Text(viewModel.followNotification ? "다른 사용자가 여러분을 팔로우하면 앱을 종료한 상태에서도 알림을 받을 수 있어요" : "앱을 종료한 상태에서는 알림이 울리지 않지만 앱 내의 알림창에서는 확인할 수 있어요")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                }
            }
        }
        .toolbarBackground(Color.SBLightBlue, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Task {
                        await viewModel.editNotificationType()
                    }
                    navRouter.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.medium)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("알림 설정")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NotificationSettingView()
        .environment(NavRouter())
}
