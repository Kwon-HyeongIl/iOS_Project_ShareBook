//
//  ProfileEditView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileEditView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @Bindable var viewModel: ProfileViewModel
    
    @State private var isTitleBookAlertShowing = false
    @State private var isProgressive = false
    
    var body: some View {
        GradientBackgroundView {
            ZStack {
                VStack {
                    PhotosPicker(selection: $viewModel.selectedItem) {
                        VStack {
                            if let profileImage = viewModel.profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .padding(.trailing, 10)
                                    .padding(.leading)
                                
                            } else if let imageUrl = viewModel.user?.profileImageUrl {
                                KFImage(URL(string: imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .padding(.trailing, 10)
                                    .padding(.leading)
                                
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .foregroundStyle(.black)
                                    .opacity(0.8)
                                    .padding(.trailing, 10)
                                    .padding(.leading)
                            }
                            
                            Text("프로필 이미지 설정")
                                .foregroundStyle(Color.SBTitle)
                                .padding(.top, 10)
                        }
                    }
                    .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                        Task {
                            await viewModel.convertImage(item: newValue)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                    
                    VStack {
                        Text("사용자 이름")
                        
                        TextField("", text: $viewModel.userName)
                            .foregroundStyle(.black)
                            .opacity(0.6)
                            .padding(.horizontal, 20)
                        
                        Divider()
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .modifier(TileModifier())
                    
                    VStack {
                        Text("즐겨보는 장르")
                            .padding(.top)
                        
                        Picker("책 장르", selection: $viewModel.titleGenre) {
                            ForEach(Genre.allCases) { genre in
                                Text(genre.rawValue).tag(genre)
                            }
                        }
                        .pickerStyle(.wheel)
                        .padding(.horizontal, 30)
                    }
                    .modifier(TileModifier())
                    
                    VStack {
                        HStack {
                            ZStack {
                                Text("나의 인생 책 구절")
                                
                                if let _ = viewModel.titlePost {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            viewModel.titlePost = nil
                                        }
                                    } label: {
                                        Text("삭제")
                                            .font(.system(size: 13))
                                            .foregroundStyle(Color.SBTitle)
                                            .frame(width: 40, height: 20)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.SBTitle, lineWidth: 1.0)
                                            }
                                            .fontWeight(.semibold)
                                            .padding(.leading, 270)
                                    }
                                }
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        
                        Button {
                            if !viewModel.posts.isEmpty {
                                navRouter.navigate(.ProfileEditPostPickerView(viewModel))
                            } else {
                                isTitleBookAlertShowing = true
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.regularMaterial)
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                    .padding(.horizontal)
                                
                                HStack {
                                    if let titlePost = viewModel.titlePost {
                                        HStack {
                                            KFImage(URL(string: titlePost.book.image))
                                                .resizable()
                                                .frame(width: 60, height: 85)
                                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                                .padding(.leading, 30)
                                                .padding(.trailing, 5)
                                            
                                            VStack {
                                                Image(systemName: "quote.opening")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(Color.SBTitle)
                                                    .frame(width: 15)
                                                    .padding(.top, 25)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            Text("\(titlePost.impressivePhrase)")
                                                .font(.system(size: 13))
                                                .multilineTextAlignment(.center)
                                                .lineLimit(4)
                                                .truncationMode(.tail)
                                            
                                            Spacer()
                                            
                                            VStack {
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 10)
                                                    .foregroundStyle(Color.SBTitle)
                                                    .fontWeight(.semibold)
                                                    .padding(.top, 25)
                                                    .padding(.trailing)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "quote.closing")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(Color.SBTitle)
                                                    .frame(width: 15)
                                                    .padding(.bottom, 25)
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
                            .foregroundStyle(.black)
                        }
                        .alert("!!", isPresented: $isTitleBookAlertShowing) {
                            Button {
                                navRouter.popToRoot()
                                mainTabCapsule.selectedTab = .plusSquareOnSquare
                            } label: {
                                Text("확인")
                            }
                        } message: {
                            Text("나의 인생 책 구절을 등록하기 위해서는 먼저 글을 작성하셔야 됩니다.")
                        }
                    }
                    .padding(.vertical)
                    .modifier(TileModifier())
                    
                    Spacer()
                }
                
                if isProgressive {
                    ProgressView()
                }
            }
        }
        .toolbarBackground(Color.SBLightBlue, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Task {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isProgressive = true
                        }
                        
                        try await viewModel.updateUser()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                isProgressive = false
                            }
                        }
                        
                        navRouter.back()
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("수정")
                    }
                    .fontWeight(.medium)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("프로필 편집")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    ProfileEditView(viewModel: ProfileViewModel(userId: "DUMMY"))
        .environment(NavRouter())
        .environment(MainTabCapsule())
}
