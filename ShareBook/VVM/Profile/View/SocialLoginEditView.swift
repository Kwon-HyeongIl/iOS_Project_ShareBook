//
//  SocialLoginEditView.swift
//  ShareBook
//
//  Created by 권형일 on 7/31/24.
//

import SwiftUI

struct SocialLoginEditView: View {
    @State var viewModel = SocialLoginEditViewModel()
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("간편 로그인 설정")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)

                HStack {
                    VStack {
                        Image("Kakao_SocialLogin_Logo")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.bottom, 4)
                    }
                    
                    Toggle("Kakao 로그인 연동", isOn: $viewModel.isKakapLogin)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .toggleStyle(SwitchToggleStyle())
                        .tint(Color(red: 112/255, green: 173/255, blue: 179/255))
                        .padding(.leading, 5)
                        .padding(.bottom, 5)
                        .onChange(of: viewModel.isKakapLogin) {
                            if viewModel.isKakapLogin { // 토글 Off -> On
                                // 카카오 로그인 연동
                            } else {
                                // 카카오 로그인 연동 취소
                            }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    Image("Apple_SocialLogin_Logo")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .clipShape(Circle())
                        .padding(.leading, 2)
                    
                    Toggle("Apple 로그인 연동", isOn: $viewModel.isAppleLogin)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .toggleStyle(SwitchToggleStyle())
                        .tint(Color(red: 112/255, green: 173/255, blue: 179/255))
                        .padding(.leading, 5)
                        .onChange(of: viewModel.isAppleLogin) {
                            if viewModel.isAppleLogin {
                                // 애플 로그인 연동
                            } else {
                                // 애플 로그인 연동 취소
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    SocialLoginEditView()
}
