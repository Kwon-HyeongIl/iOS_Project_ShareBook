//
//  Views.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import Foundation

enum NavStackView: Hashable {
    
    // NewPost
    case NewPostUploadPostView(Book)
    
    // Profile
    case ProfileView(User?, CommentSheetCapsule?)
    case ProfileEditView(ProfileViewModel)
    case ProfileOptionView
    case ProfileEditPostPickerView(ProfileViewModel)
    
    case FeedbackView
    
    // Post
    case PostProfileCoverView(Post)
    case PostDetailView(PostViewModel, CommentSheetCapsule)
    
    // Book
    case BookDetailView(BookViewModel)
}
