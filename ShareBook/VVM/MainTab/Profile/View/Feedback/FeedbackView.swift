//
//  FeedbackView.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel = FeedbackViewModel()
    
    @State private var isContentAlertShowing = false
    @State private var isSubmitAlertShowing = false
    @State private var isSubmitFinishAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                VStack {
                    TextField("", text: $viewModel.content, axis: .vertical)
                        .padding(.horizontal)
                        .frame(height: 160)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 30)
                        .padding(.top, 25)
                        .overlay {
                            if viewModel.content.isEmpty {
                                Text("건의할 내용을 입력해주세요!")
                                    .modifier(ItalicFontModifier())
                                    .font(.caption)
                                    .opacity(0.2)
                            }
                    }
                    
                    Button {
                        if viewModel.content.isEmpty {
                            isContentAlertShowing = true
                        } else {
                            isSubmitAlertShowing = true
                        }
                            
                    } label: {
                        if viewModel.content.isEmpty {
                            Text("제출")
                                .modifier(InViewButtonModifier(bgColor: .gray))
                        } else {
                            Text("제출")
                                .modifier(InViewButtonModifier(bgColor: .sBColor))
                        }
                    }
                    .alert("!!", isPresented: $isContentAlertShowing) {
                        
                    } message: {
                        Text("공란으로 제출할 수 없습니다.")
                    }
                    .alert("제출 하시겠습니까?", isPresented: $isSubmitAlertShowing) {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("취소")
                        }
                        
                        Button {
                            Task {
                                await viewModel.feedback()
                            }
                            isSubmitFinishAlertShowing = true
                        } label: {
                            Text("계속")
                        }
                    } message: {
                        Text("작성하신 내용은 앱 개발자에게 전송됩니다.")
                    }
                    .alert("성공적으로 제출하였습니다!", isPresented: $isSubmitFinishAlertShowing) {
                        Button {
                            navStackControlTower.pop()
                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("제출하신 내용을 면밀히 검토하여 다음 업데이트에 적극 반영하겠습니다! 감사합니다.")
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.bottom)
                .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                
                Spacer()
                
            }
        }
        .navigationTitle("건의하기")
        .modifier(BackButtonModifier())
    }
}

#Preview {
    FeedbackView()
        .environment(NavStackControlTower())
}
