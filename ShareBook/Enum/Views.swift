//
//  Views.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import Foundation

enum Views: Hashable {
    // Home
    case HomeView
    
    // NewPost
    case NewPostView
    case NewPostUploadPostView(Book)
    
    // Like
    case LikeView
    case LikePostView(CGFloat)
    case BookmarkBookView
    
    // Profile
    case ProfileView(User?)
    
    // Common.Post
    case PostCoverView(Post)
    case PostProfileCoverView(Post)
    case PostDetailView(PostViewModel)
    
    // Common.Book
    case BookCoverView(Book)
    case BookDetailView(BookViewModel)
}
