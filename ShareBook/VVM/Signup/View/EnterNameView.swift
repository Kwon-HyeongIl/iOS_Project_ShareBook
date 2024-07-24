//
//  EnterNameView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct EnterNameView: View {
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        @Bindable var viewModel = signupViewModel
        
        GradientBackgroundView {
            VStack {
                Text("성함을 입력하세요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 25)
                
                Text("이 성함은 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                TextField("성함", text: $viewModel.name)
                    .modifier(TextFieldModifier())
                    .padding(.bottom, 5)
                
                HStack {
                    NavigationLink {
                        EnterUsernameView()
                    } label: {
                        Text("다음")
                            .modifier(ButtonModifier())
                    }
                    .padding(.horizontal)
                    
                }
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\"남의 책을 많이 읽어라. 남이 고생하여 얻은 지식을 아주 쉽게 내것으로 만들 수 있고, 그것으로 자기 발전을 이룰 수 있다.\"")
                        .modifier(ItalicFontModifier())
                        .multilineTextAlignment(.center)
                    Text("- 소크라테스")
                        .modifier(ItalicFontModifier())
                        .opacity(0.5)
                }
                .padding()
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray.opacity(0.8), radius: 10, x: 5, y: 5)
                .padding(.horizontal)
                Spacer()
            }
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    EnterNameView()
}
