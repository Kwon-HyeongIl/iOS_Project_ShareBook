//
//  FollowingView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI

struct FollowingView: View {
    @State private var viewModel: FollowingViewModel
    
    init(user: User?) {
        self.viewModel = FollowingViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if !viewModel.isRedacted {
                    ForEach(viewModel.users.indices, id: \.self) { index in
                        ProfileCoverView(user: viewModel.users[index])
                            .padding(.top, index == 0 ? 10 : 0)
                            .padding(.bottom, index == viewModel.users.count-1 ? 20 : 0)
                    }
                } else {
                    ForEach(0..<10, id: \.self) { index in
                        DummyProfileCoverView()
                            .padding(.top, index == 0 ? 10 : 0)
                            .padding(.bottom, index == 9 ? 20 : 0)
                    }
                }
            }
        }
        .task {
            Task {
                await viewModel.loadAllFollowings()
            }
        }
        .task {
            if viewModel.isFirstLoad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        viewModel.isRedacted = false
                    }
                }
                
                viewModel.isFirstLoad = false
            }
        }
    }
}

#Preview {
    FollowingView(user: nil)
}