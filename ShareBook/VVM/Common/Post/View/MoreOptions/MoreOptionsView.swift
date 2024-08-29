//
//  PostMoreOptionsView.swift
//  ShareBook
//
//  Created by 권형일 on 8/22/24.
//

import SwiftUI

struct MoreOptionsView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State var viewModel: MoreOptionsViewModel
    
    @State var isDeleteAlertShowing = false
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
                        .fontWeight(.bold)
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
                                navStackControlTower.pop()
                            }
                        } label: {
                            Text("삭제")
                        }
                    } message: {
                        Text("삭제한 글은 다시 복원할 수 없습니다.")
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MoreOptionsView(post: Post.DUMMY_POST, isMoreOptionsSheetShowing: .constant(true))
        .environment(NavStackControlTower())
}
