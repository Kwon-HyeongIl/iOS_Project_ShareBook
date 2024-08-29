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
            
        // NewPost
        case .NewPostUploadPostView(let book):
            NewPostUploadPostView(book: book)
            
        // Profile
        case .ProfileView(let user):
            ProfileView(user: user)
        case .ProfileEditView(let user):
            ProfileEditView(user: user)
        case .ProfileOptionView(let user):
            ProfileOptionView(user: user)
            
        // Post
        case .PostProfileCoverView(let post):
            PostProfileCoverView(post: post)
        case .PostDetailView(let viewModel):
            PostDetailView(viewModel: viewModel)
            
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
