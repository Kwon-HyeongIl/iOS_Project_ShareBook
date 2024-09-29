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
    
    @State private var loginAlertShowing = false
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    ZStack {
                        FullGirl3DView()
                            .padding(.bottom, proxy.size.height < 700 ? 260 : 180)
                        
                        VStack {
                            Image("ShareBook_TextLogo")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Rectangle())
                                .frame(width: 190)
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                .padding(.top, proxy.size.height < 700 ? 0 : 50)

                            TextField("이메일 주소", text: $viewModel.email)
                                .modifier(TextFieldModifier())
                                .padding(.bottom, 10)
                                .padding(.top, proxy.size.height < 700 ? proxy.size.height - 410 : proxy.size.height - 480)
                            
                            SecureField("비밀번호", text: $viewModel.password)
                                .modifier(TextFieldModifier())
                                .padding(.bottom, 10)
                            
                            Button {
                                Task {
                                    let result = await viewModel.login()
                                    if !result {
                                        loginAlertShowing = true
                                    }
                                }
                            } label: {
                                Text("로그인")
                                    .modifier(AuthViewButtonModifier(bgColor: .SBTitle))
                            }
                            .alert("!!", isPresented: $loginAlertShowing) {
                                Button {
                                    
                                } label: {
                                    Text("확인")
                                }
                            } message: {
                                Text("이메일 또는 비밀번호가 일치하지 않습니다.")
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
                            .padding(.horizontal)
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
                            .padding(.bottom, 10)
                            
                            HStack(spacing: 20) {
                                Button {
                                    viewModel.kakaoAuthSignIn()
                                } label: {
                                    Image("Kakao_SocialLogin_Logo")
                                        .resizable()
                                        .frame(width: 55, height: 55)
                                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                                }
                                
                                Button {
                                    viewModel.appleAuthSignin()
                                } label: {
                                    Image("Apple_SocialLogin_Logo")
                                        .resizable()
                                        .frame(width: 55, height: 55)
                                        .clipShape(Circle())
                                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                }
                            }
                            .padding(.bottom)
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(NavRouter())
}

