//
//  LoginView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        GradientBackgroundView {
            ZStack {
                FullGirl3DView()
                    .padding(.bottom, 260)
                
                VStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .frame(width: 130)
                        .padding(.top, 50)
                    Spacer()
                    
                    TextField("이메일 주소", text: $viewModel.email)
                        .modifier(TextFieldModifier())
                        .padding(.bottom, 10)
                        .padding(.top, 250)
                    
                    SecureField("비밀번호", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                        .padding(.bottom, 10)
                    
                    Button {
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        Text("로그인")
                            .modifier(AuthViewButtonModifier())
                    }
                    
                    HStack {
                        Text("비밀번호를 잊으셨나요?")
                            .font(.system(size: 13))
                            .padding(.leading, 25)
                        Spacer()
                        
                        Button {
                            navRouter.navigate(.EnterEmailView)
                        } label: {
                            Text("회원가입")
                                .font(.system(size: 13))
                                .foregroundStyle(.blue)
                                .padding(.trailing, 25)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    .padding(.top, 5)
                    
                    HStack {
                        VStack {
                            Divider().frame(width: 100)
                        }
                        Text("또는, 다음으로 계속하기")
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                        VStack {
                            Divider().frame(width: 100)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 20) {
                        Button {
                            viewModel.kakaoAuthSignIn()
                        } label: {
                            Image("Kakao_SocialLogin_Logo")
                                .resizable()
                                .frame(width: 55, height: 55)
                        }
                        
                        Button {
                            viewModel.appleAuthSignin()
                        } label: {
                            Image("Apple_SocialLogin_Logo")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(NavRouter())
}

