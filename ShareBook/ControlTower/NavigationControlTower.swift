//
//  NavigationCoordinator.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import SwiftUI

@Observable
class NavigationControlTower {
    var paths = NavigationPath()
    
    @ViewBuilder
    func navigate(to view: Views) -> some View {
        switch view {
            
        // Home
        case .HomeView:
            HomeView()
            
        // NewPost
        case .NewPostView:
            NewPostView()
        case .NewPostUploadPostView(let book):
            NewPostUploadPostView(book: book)
            
        // Like
        case .LikeView:
            LikeView()
        case .LikePostView(let proxyWidth):
            LikePostView(proxyWidth: proxyWidth)
        case .BookmarkBookView:
            BookmarkBookView()
            
        // Profile
        case .ProfileView:
            ProfileView()
            
        // Common.Post
        case .PostCoverView(let post):
            PostCoverView(post: post)
        case .PostDetailView(let viewModel):
            PostDetailView(viewModel: viewModel)
            
        // Common.Book
        case .BookCoverView(let book):
            BookCoverView(book: book)
        case .BookDetailView(let viewModel):
            BookDetailView(viewModel: viewModel)
        }
    }
    
    func navPush(_ view: Views) {
        paths.append(view)
    }
    
    func navPop() {
        paths.removeLast()
    }
    
    func popToRoot() {
        paths.removeLast(paths.count)
    }
}
