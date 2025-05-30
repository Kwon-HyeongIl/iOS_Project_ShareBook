//
//  EnterPasswordView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct EnterPasswordView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @Environment(SignupViewModel.self) var viewModel
    
    @FocusState private var focus: SignupFocusField?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        GradientBackgroundView {
            VStack {
                Text("비밀번호를 입력하세요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 25)
                
                Text("8자리 이상, 영문자 또는 특수문자와 조합하세요.")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                SecureField("비밀번호", text: $viewModel.password)
                    .modifier(TextFieldModifier())
                    .focused($focus, equals: .main)
                    .padding(.bottom, 5)
                
                Button {
                    if viewModel.password.count >= 8 {
                        navRouter.navigate(.EnterUsernameView)
                    }
                } label: {
                    if viewModel.password.count >= 8 {
                        Text("다음")
                            .modifier(AuthViewButtonModifier(bgColor: .SBTitle))
                    } else {
                        Text("다음")
                            .modifier(AuthViewButtonModifier(bgColor: .gray))
                    }
                }
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\"모든 양서를 읽는 것은 지난 몇 세기 동안 걸친 가장 훌륭한 사람들과 대화 하는 것과 같다\"")
                        .modifier(ItalicFontModifier())
                        .multilineTextAlignment(.center)
                    Text("- 데카르트")
                        .modifier(ItalicFontModifier())
                        .opacity(0.5)
                }
                .padding()
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .modifier(BackModifier())
        .onAppear {
            focus = .main
        }
    }
}

#Preview {
    EnterPasswordView()
        .environment(SignupViewModel())
        .environment(NavigationRouter())
}
