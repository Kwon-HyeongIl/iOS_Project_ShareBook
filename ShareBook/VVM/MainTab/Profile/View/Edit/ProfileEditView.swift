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
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel = ProfileEditViewModel()
    
    @Environment(SelectedMainTabCapsule.self) var selectedMainTabCapsule: SelectedMainTabCapsule
    
    @State private var isTitleBookAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    VStack {
                        if let imageUrl = viewModel.profileImageUrl {
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                                .padding(.leading)
                            
                        } else if let profileImage = viewModel.profileImage {
                            profileImage
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
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 10)
                    }
                }
                .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                    Task {
                        await viewModel.convertImage(item: newValue)
                    }
                    viewModel.isImageChanged = true
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                VStack {
                    Text("사용자 이름")
                    
                    TextField("", text: $viewModel.username)
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
                        ForEach(Genre.allCases.dropFirst()) { genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.horizontal, 30)
                }
                .modifier(TileModifier())
                
                VStack {
                    Text("나의 인생 책 구절")
                        .padding(.top, 5)
                    
                    Button {
                        if !viewModel.posts.isEmpty {
                            navStackControlTower.push(.ProfileEditPostPickerView(viewModel))
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
                                .padding(.horizontal, 20)
                            
                            HStack {
                                if let bookImageUrl = viewModel.titleBookImageUrl {
                                    HStack {
                                        KFImage(URL(string: bookImageUrl))
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
                                                .padding(.top, 25)
                                            
                                            Spacer()
                                        }
                                        
                                        Text("\(viewModel.titleBookImpressivePhrase ?? "")")
                                            .font(.system(size: 13))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(4)
                                            .truncationMode(.tail)
                                            
                                        VStack {
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10)
                                                .foregroundStyle(Color.sBColor)
                                                .fontWeight(.bold)
                                                .padding(.top, 25)
                                                .padding(.trailing)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "quote.closing")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(Color.sBColor)
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
                            navStackControlTower.popToRoot()
                            selectedMainTabCapsule.selectedTab = .plusSquareOnSquare
                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("나의 인생 책 구절을 등록하기 위해서는 먼저 글을 작성하셔야 됩니다.")
                    }
                }
                .padding(.vertical)
                .modifier(TileModifier())
                
                Button {
                    Task {
                        try await viewModel.updateUser()
                        navStackControlTower.pop()
                    }
                } label: {
                    Text("수정")
                        .modifier(InViewButtonModifier(bgColor: .sBColor))
                }
                
                Spacer()
            }
        }
        .navigationTitle("프로필 편집")
        .modifier(BackButtonModifier())
    }
}

#Preview {
    ProfileEditView()
        .environment(NavStackControlTower())
        .environment(SelectedMainTabCapsule())
}
