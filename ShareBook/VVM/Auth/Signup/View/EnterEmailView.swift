//
//  EnterEmailView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct EnterEmailView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(SignupViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        GradientBackgroundView {
            VStack {
                Text("이메일 주소를 입력하세요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 25)
                
                Text("이 이메일 주소는 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                TextField("이메일 주소", text: $viewModel.email)
                    .modifier(TextFieldModifier())
                    .padding(.bottom, 5)
                
                Button {
                    navRouter.move(.EnterPasswordView)
                } label: {
                    Text("다음")
                        .modifier(AuthViewButtonModifier())
                        .padding(.horizontal)
                }
                    
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\"내가 세계를 알게 된 것은 책에 의해서였다\"")
                        .modifier(ItalicFontModifier())
                        .multilineTextAlignment(.center)
                    Text("- 사르트르")
                        .modifier(ItalicFontModifier())
                        .opacity(0.5)
                }
                .padding()
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                .padding(.horizontal)
                Spacer()
            }
        }
        .modifier(BackModifier())
    }
}

#Preview {
    EnterEmailView()
        .environment(NavRouter())
        .environment(SignupViewModel())
}
