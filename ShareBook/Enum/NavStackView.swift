//
//  Views.swift
//  ShareBook
//
//  Created by 권형일 on 8/26/24.
//

import Foundation

enum NavStackView: Hashable {
    
    // Signup
    case EnterEmailView
    case EnterPasswordView
    case EnterUsernameView
    case CompleteSignupView
    
    // Home
    case PostSearchView
    case NotificationsView
    
    // NewPost
    case NewPostUploadPostView(Book)
    
    // Profile
    case ProfileView(User?, CommentSheetCapsule? = nil)
    case ProfileEditView(ProfileViewModel)
    case ProfileOptionView(ProfileViewModel)
    case ProfileEditPostPickerView(ProfileViewModel)
    
    case FeedbackView
    case NotificationSettingView
    
    // Post
    case PostProfileCoverView(Post)
    case PostDetailView(PostViewModel, CommentSheetCapsule)
    
    // Book
    case BookDetailView(BookViewModel)
}
