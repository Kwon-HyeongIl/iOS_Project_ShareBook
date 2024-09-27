//
//  CompleteSignupView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct CompleteSignupView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(SignupViewModel.self) var viewModel
    
    var body: some View {
        GradientBackgroundView {
            ZStack {
                Girl3DView()
                    .padding(.bottom, 200)
                
                VStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .frame(width: 210)
                        .padding(.top)
                    Spacer()
                    
                    Text("\(viewModel.username)님, 환영합니다")
                        .font(.title)
                        .padding(.top, 120)
                        .padding(.bottom, 30)
                    
                    Text("여러분이 책에서 발견한 가치를 공유하고, 더 큰 가치를 발견하세요!")
                        .frame(width: 363)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .opacity(0.8)
                        .modifier(ItalicFontModifier())
                    
                    Button {
                        Task {
                            await viewModel.createUser()
                            navRouter.popToRoot()
                        }
                    } label: {
                        Text("완료")
                            .modifier(AuthViewButtonModifier())
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .padding(.top, 100)
        }
        .modifier(BackModifier())
    }
}

#Preview {
    CompleteSignupView()
        .environment(SignupViewModel())
        .environment(NavRouter())
}
