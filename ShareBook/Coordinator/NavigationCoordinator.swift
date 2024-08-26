//
//  NavigationCoordinator.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import SwiftUI

@Observable
class NavigationCoordinator {
    var paths = NavigationPath()
    
    @ViewBuilder
    func navigate(to view: Views) -> some View {
        switch view {
            
        case .NewPostView:
            NewPostView()
            
        case .NewPostBookCoverView(let book):
            NewPostBookCoverView(book: book)
            
        case .NewPostBookDetailView(let viewModel):
            NewPostBookDetailView(viewModel: viewModel)
            
        case .NewPostUploadPostView(let book):
            NewPostUploadPostView(book: book)
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

enum Views: Hashable {
    case NewPostView
    case NewPostBookCoverView(Book)
    case NewPostBookDetailView(NewPostBookViewModel)
    case NewPostUploadPostView(Book)
}
