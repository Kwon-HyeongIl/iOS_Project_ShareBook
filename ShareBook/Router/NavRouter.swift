//
//  NavigationCoordinator.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import SwiftUI

@Observable
class NavRouter {
    var path = NavigationPath()
    
    @ViewBuilder
    func destinationNavigate(to view: NavStackView) -> some View {
        switch view {
            
        // Signup
        case .EnterEmailView:
            EnterEmailView()
        case .EnterPasswordView:
            EnterPasswordView()
        case .EnterUsernameView:
            EnterUsernameView()
        case .CompleteSignupView:
            CompleteSignupView()
            
        // Home
        case .PostSearchView:
            PostSearchView()
        case .NotificationsView:
            NotificationsView()
            
        // NewPost
        case .SearchBookView:
            SearchBookView()
        case .NewPostUploadPostView(let book):
            UploadPostView(book: book)
            
        // Profile
        case .ProfileView(let userId, let commentSheetCapsule):
            ProfileView(userId: userId, commentSheetCapsule: commentSheetCapsule)
        case .ProfileEditView(let viewModel):
            ProfileEditView(viewModel: viewModel)
        case .ProfileOptionView(let viewModel):
            ProfileOptionView(viewModel: viewModel)
        case .ProfileEditPostPickerView(let viewModel):
            ProfileEditPostPickerView(viewModel: viewModel)
        case .FollowView(let type, let user):
            FollowView(type: type, user: user)
        case .AccountDeleteView:
            AccountDeleteView()
            
        case .FeedbackView:
            FeedbackView()
        case .NotificationSettingView:
            NotificationSettingView()
            
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
    
    @MainActor
    func navigate(_ view: NavStackView) {
        path.append(view)
    }
    
    @MainActor
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    @MainActor
    func popToRoot() {
        if !path.isEmpty {
            path.removeLast(path.count)
        }
    }
}
