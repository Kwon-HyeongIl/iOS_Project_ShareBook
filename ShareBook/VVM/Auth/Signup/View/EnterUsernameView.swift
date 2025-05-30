//
//  EnterUsernameView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct EnterUsernameView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @Environment(SignupViewModel.self) var viewModel
    
    @FocusState private var focus: SignupFocusField?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        GradientBackgroundView {
            VStack {
                Text("닉네임을 입력하세요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 25)
                
                Text("앱 내에서 다른 사람에게 보여지는 닉네임을 입력하세요.")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                TextField("닉네임", text: $viewModel.username)
                    .modifier(TextFieldModifier())
                    .focused($focus, equals: .main)
                    .padding(.bottom, 5)
                
                Button {
                    if !viewModel.username.isEmpty {
                        navRouter.navigate(.CompleteSignupView)
                    }
                } label: {
                    if !viewModel.username.isEmpty {
                        Text("다음")
                            .modifier(AuthViewButtonModifier(bgColor: .SBTitle))
                    } else {
                        Text("다음")
                            .modifier(AuthViewButtonModifier(bgColor: .gray))
                    }
                }
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\"담론은 재치있는 사람을, 필기는 정확한 사람을, 독서는 완성된 사람을 만든다.\"")
                        .modifier(ItalicFontModifier())
                        .multilineTextAlignment(.center)
                    Text("- 프란시스 베이컨")
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
    EnterUsernameView()
        .environment(SignupViewModel())
        .environment(NavigationRouter())
}
