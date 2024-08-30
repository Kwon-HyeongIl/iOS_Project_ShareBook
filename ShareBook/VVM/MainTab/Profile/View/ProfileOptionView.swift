//
//  ProfileOptionView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileOptionView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel: ProfileOptionViewModel
    
    @State private var isLogoutAlertShowing = false
    
    init(user: User?) {
        self.viewModel = ProfileOptionViewModel(user: user)
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                HStack {
                    Text("내 프로필")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                        .padding(.leading)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                Button {
                    navStackControlTower.push(.FeedbackView)
                } label: {
                    HStack {
                        Image(systemName: "exclamationmark.bubble")
                        Text("건의하기")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                    .font(.system(size: 18))
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    isLogoutAlertShowing = true
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("로그아웃")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .font(.system(size: 18))
                    .padding(.top, 10)
                }
                .alert("정말 로그아웃 하시겠습니까?", isPresented: $isLogoutAlertShowing) {
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("취소")
                    }
                    
                    Button(role: .destructive) {
                        withAnimation(.smooth(duration: 0.4)) {
                            viewModel.signout()
                        }
                    } label: {
                        Text("계속")
                    }
                }
                
                Spacer()
            }
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    ProfileOptionView(user: User.DUMMY_USER)
        .environment(NavStackControlTower())
}
