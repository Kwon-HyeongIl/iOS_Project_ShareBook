//
//  ProfileOptionView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileOptionView: View {
    @State private var viewModel: ProfileOptionViewModel
    
    @State private var isLogoutAlertShowing = false
    
    init(user: User?) {
        self.viewModel = ProfileOptionViewModel(user: user)
    }
    
    var body: some View {
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
                
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("로그아웃")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.red)
                .opacity(0.8)
                .padding(.horizontal)
                .font(.system(size: 18))
                .fontWeight(.semibold)
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
}

#Preview {
    ProfileOptionView(user: User.DUMMY_USER)
}
