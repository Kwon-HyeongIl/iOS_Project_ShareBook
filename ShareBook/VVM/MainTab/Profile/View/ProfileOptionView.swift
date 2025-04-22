//
//  ProfileOptionView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileOptionView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @Bindable var viewModel: ProfileViewModel
    
    @State private var isLogoutAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Button {
                    navRouter.navigate(.FeedbackView)
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
                    .fontWeight(.medium)
                    .padding(.top)
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    navRouter.navigate(.NotificationSettingView)
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
                    .fontWeight(.medium)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    navRouter.navigate(.AccountDeleteView)
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "person.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                        
                        Text("계정 삭제")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .padding(.top, 10)
                }
                
                Spacer()
                
                Button {
                    isLogoutAlertShowing = true
                } label: {
                    Text("로그아웃")
                        .font(.system(size: 14))
                        .foregroundStyle(.red)
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
            }
        }
        .modifier(BackTitleModifier(navigationTitle: "설정"))
    }
}

#Preview {
    ProfileOptionView(viewModel: ProfileViewModel(userId: "DUMMY"))
        .environment(NavigationRouter())
        .environment(MainTabCapsule())
}
