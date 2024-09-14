//
//  ProfileOptionView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileOptionView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @Bindable var viewModel: ProfileViewModel
    
    @State private var isLogoutAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Button {
                    navRouter.move(.FeedbackView)
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "exclamationmark.bubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17)
                        
                        Text("건의하기")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                    .font(.system(size: 17))
                    .padding(.top)
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    navRouter.move(.NotificationSettingView)
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        
                        Text("알림 설정")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                    .font(.system(size: 17))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    isLogoutAlertShowing = true
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                        
                        Text("로그아웃")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .font(.system(size: 17))
                    .padding(.top, 10)
                }
                .alert("정말 로그아웃 하시겠습니까?", isPresented: $isLogoutAlertShowing) {
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("취소")
                    }
                    
                    Button(role: .destructive) {
                        withAnimation(.easeOut(duration: 0.4)) {
                            viewModel.signOut()
                        }
                        navRouter.popToRoot()
                        mainTabCapsule.selectedTab = .house
                        
                        appDelegate.refreshDeviceToken()
                    } label: {
                        Text("계속")
                    }
                }
                
                Spacer()
            }
        }
        .modifier(BackTitleModifier(navigationTitle: "설정"))
    }
}

#Preview {
    ProfileOptionView(viewModel: ProfileViewModel(user: User.DUMMY_USER))
        .environment(NavRouter())
        .environment(MainTabCapsule())
}
