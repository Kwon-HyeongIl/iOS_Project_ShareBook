//
//  ProfileView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel: ProfileViewModel
    
    @State private var isUnFollowAlertShowing = false
    var commentSheetCapsule: CommentSheetCapsule?

    init(user: User?, commentSheetCapsule: CommentSheetCapsule?) {
        self.viewModel = ProfileViewModel(user: user)
        self.commentSheetCapsule = commentSheetCapsule
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    VStack(spacing: 5) {
                        if let isMyProfile = viewModel.isMyProfile, isMyProfile {
                            HStack {
                                Text("내 프로필")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.sBColor)
                                .opacity(0.6)
                                .frame(height: 330)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                            
                            VStack(spacing: 0) {
                                HStack {
                                    if let profileImage = viewModel.profileImage {
                                        profileImage
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                        
                                    } else if let imageUrl = viewModel.user?.profileImageUrl {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                        
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .opacity(0.8)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("\(viewModel.userName)")
                                            .font(.system(size: 18))
                                            .foregroundStyle(.black)
                                            .fontWeight(.semibold)
                                        
                                        Text("\(viewModel.titleGenre.rawValue)")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    if let isMyProfile = viewModel.isMyProfile, isMyProfile {
                                        Button {
                                            navStackControlTower.push(.ProfileOptionView)
                                        } label: {
                                            Image(systemName: "gearshape")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25)
                                                .foregroundStyle(.black)
                                                .opacity(0.7)
                                                .padding(.trailing, 20)
                                                .padding(.bottom, 20)
                                        }
                                    }
                                }
                                .padding(.bottom)
                                
                                HStack(spacing: 60) {
                                    VStack(spacing: 3) {
                                        Text("기록한 구절")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.posts.count)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로워")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.followerCount)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로잉")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.followingCount)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                
                                if let isMyProfile = viewModel.isMyProfile, isMyProfile {
                                    Button {
                                        navStackControlTower.push(.ProfileEditView(viewModel))
                                    } label: {
                                        VStack {
                                            Text("프로필 편집")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color.sBColor)
                                        }
                                        .frame(height: 35)
                                        .frame(maxWidth: .infinity)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.sBColor, lineWidth: 1.0)
                                        }
                                        .padding(.horizontal, 50)
                                        .padding(.bottom, 10)
                                    }
                                    
                                } else {
                                    if viewModel.isFollow == true {
                                        Button {
                                            isUnFollowAlertShowing = true
                                        } label: {
                                            VStack {
                                                Text("팔로우 취소")
                                                    .font(.system(size: 15))
                                                    .fontWeight(.semibold)
                                                    .foregroundStyle(Color.sBColor)
                                            }
                                            .frame(height: 35)
                                            .frame(maxWidth: .infinity)
                                            .background(.thinMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.sBColor, lineWidth: 1.0)
                                            }
                                            .padding(.horizontal, 50)
                                            .padding(.bottom, 10)
                                        }
                                        .alert("정말 팔로우를 취소하시겠습니까?", isPresented: $isUnFollowAlertShowing) {
                                            Button(role: .cancel) {
                                                
                                            } label: {
                                                Text("취소")
                                            }
                                            
                                            Button(role: .destructive) {
                                                Task {
                                                    await viewModel.unFollow()
                                                }
                                            } label: {
                                                Text("계속")
                                            }
                                            
                                        } message: {
                                            
                                        }
                                        
                                    } else {
                                        Button {
                                            Task {
                                                await viewModel.follow()
                                            }
                                        } label: {
                                            VStack {
                                                Text("팔로우")
                                                    .font(.system(size: 15))
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.white)
                                            }
                                            .frame(height: 35)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.sBColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding(.horizontal, 50)
                                            .padding(.bottom, 10)
                                        }
                                    }
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.regularMaterial)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        if let titlePost = viewModel.titlePost {
                                            HStack {
                                                KFImage(URL(string: titlePost.book.image))
                                                    .resizable()
                                                    .frame(width: 60, height: 85)
                                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                                    .padding(.leading, 30)
                                                    .padding(.trailing, 5)
                                                
                                                Spacer()
                                                
                                                VStack {
                                                    Image(systemName: "quote.opening")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundStyle(Color.sBColor)
                                                        .frame(width: 15)
                                                        .padding(.bottom, 70)
                                                }
                                                
                                                Text("\(titlePost.impressivePhrase)")
                                                    .font(.system(size: 13))
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .truncationMode(.tail)
                                                    
                                                VStack {
                                                    Image(systemName: "quote.closing")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundStyle(Color.sBColor)
                                                        .frame(width: 15)
                                                        .padding(.top, 70)
                                                        .padding(.trailing, 40)
                                                }
                                            }
                                        } else {
                                            ZStack {
                                                Image(systemName: "book.closed")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 45)
                                                    .foregroundStyle(.gray)
                                                
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.gray)
                                                    .padding(.leading, 6)
                                                    .padding(.bottom, 11)
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 10)
                            }
                        }
                        
                        LazyVGrid(columns: columns, spacing: viewModel.calSizeBase4And393(proxyWidth: proxy.size.width)) {
                            ForEach(viewModel.posts) { post in
                                PostProfileCoverView(post: post)
                                    .scaleEffect(viewModel.calSizemBase1And393(proxyWidth: proxy.size.width))
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !navStackControlTower.path.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            navStackControlTower.pop()
                            if let commentSheetCapsule {
                                commentSheetCapsule.isCommentSheetShowing = true
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(.black)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(user: User.DUMMY_USER, commentSheetCapsule: nil)
        .environment(NavStackControlTower())
}
