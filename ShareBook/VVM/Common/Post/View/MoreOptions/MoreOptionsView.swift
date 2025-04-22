//
//  PostMoreOptionsView.swift
//  ShareBook
//
//  Created by 권형일 on 8/22/24.
//

import SwiftUI

struct MoreOptionsView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @State private var viewModel: MoreOptionsViewModel
    
    @State private var isDeleteAlertShowing = false
    @State private var isReportAlertShowing = false
    @State private var isReportFinishAlertShowing = false
    @Binding var isMoreOptionsSheetShowing: Bool
    
    init(post: Post, isMoreOptionsSheetShowing: Binding<Bool>) {
        self.viewModel = MoreOptionsViewModel(post: post)
        self._isMoreOptionsSheetShowing = isMoreOptionsSheetShowing
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("더보기")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 15)
                    .padding(.top, 30)
                
                Divider()
                
                if viewModel.isMyPost {
                    Button {
                        isDeleteAlertShowing = true
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "trash")
                            Text("글 삭제")
                        }
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                        .opacity(0.8)
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.top)
                    }
                    .alert("삭제 하시겠습니까?", isPresented: $isDeleteAlertShowing) {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("취소")
                        }
                        
                        Button(role: .destructive) {
                            Task {
                                await viewModel.deletePost()
                                isMoreOptionsSheetShowing = false
                                navRouter.back()
                            }
                        } label: {
                            Text("삭제")
                        }
                    } message: {
                        Text("삭제한 글은 다시 복원할 수 없습니다.")
                    }
                } else {
                    Button {
                        isReportAlertShowing = true
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle")
                            Text("글 신고")
                        }
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                        .opacity(0.8)
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.top)
                    }
                    .alert("정말 신고하시겠습니까?", isPresented: $isReportAlertShowing) {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("취소")
                        }
                        
                        Button(role: .destructive) {
                            Task {
                                await viewModel.reportPost()
                            }
                            isReportFinishAlertShowing = true
                        } label: {
                            Text("계속")
                        }
                    } message: {
                        Text("불건전한 내용의 글일 경우 관리자가 확인 후, 글 삭제 및 글 사용자의 제재 처리가 진행됩니다")
                    }
                    .alert("신고 접수가 완료되었습니다", isPresented: $isReportFinishAlertShowing) {
                        Button {
                            isMoreOptionsSheetShowing = false
                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("빠른 시일 내에 해당 신고 건을 처리하겠습니다. 감사합니다.")
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MoreOptionsView(post: Post.DUMMY_POST, isMoreOptionsSheetShowing: .constant(true))
        .environment(NavigationRouter())
}
