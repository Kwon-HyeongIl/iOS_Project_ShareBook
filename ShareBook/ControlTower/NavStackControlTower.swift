//
//  NavigationCoordinator.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import SwiftUI

@Observable
class NavStackControlTower {
    var path = NavigationPath()
    
    @ViewBuilder
    func navigate(to view: NavStackView) -> some View {
        switch view {
            
        // Home
        case .PostSearchView:
            PostSearchView()
            
        // NewPost
        case .NewPostUploadPostView(let book):
            NewPostUploadPostView(book: book)
            
        // Profile
        case .ProfileView(let user, let commentSheetCapsule):
            ProfileView(user: user, commentSheetCapsule: commentSheetCapsule)
        case .ProfileEditView(let viewModel):
            ProfileEditView(viewModel: viewModel)
        case .ProfileOptionView(let viewModel):
            ProfileOptionView(viewModel: viewModel)
        case .ProfileEditPostPickerView(let viewModel):
            ProfileEditPostPickerView(viewModel: viewModel)
            
        case .FeedbackView:
            FeedbackView()
            
        // Post
        case .PostProfileCoverView(let post):
            PostProfileCoverView(post: post)
        case .PostDetailView(let viewModel, let commentSheetCapsule):
            PostDetailView(viewModel: viewModel, commentSheetCapsule: commentSheetCapsule)
            
        // Book
        case .BookDetailView(let viewModel):
            BookDetailView(viewModel: viewModel)
        }
    }
    
    func push(_ view: NavStackView) {
        path.append(view)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
