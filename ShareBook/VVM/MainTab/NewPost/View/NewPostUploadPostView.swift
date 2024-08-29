//
//  UploadPostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI
import Kingfisher

struct NewPostUploadPostView: View {
    @Environment(NavigationControlTower.self) var navControlTower: NavigationControlTower
    @State var viewModel: NewPostUploadPostViewModel
    
    @Environment(SelectedMainTabCapsule.self) var selectedMainTabCapsule
    
    @State var isImpressivePhraseShowing = true
    @State var isImpressiveAlertShowing = false
    @State var isFeelingCaptionShowing = false
    @State var isGenreShowing = false
    
    init(book: Book) {
        self.viewModel = NewPostUploadPostViewModel(book: book)
    }
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                VStack {
                    Text("글 작성")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    BookCoverContentView(book: viewModel.book)
                        .padding(.bottom, 10)
                    
                    VStack {
                        if isImpressivePhraseShowing {
                            Text("인상깊은 구절")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            TextField("", text: $viewModel.impressivePhrase, axis: .vertical)
                                .padding(.horizontal)
                                .frame(height: 160)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 30)
                                .overlay {
                                    if viewModel.impressivePhrase.isEmpty {
                                        Text("큰 따옴표(\")는 자동으로 붙습니다")
                                            .modifier(ItalicFontModifier())
                                            .font(.caption)
                                            .opacity(0.2)
                                    }
                                }
                            
                        } else if !isImpressivePhraseShowing {
                            Text("인상깊은 구절")
                                .fontWeight(.semibold)
                                .opacity(0.5)
                                .padding(.top)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 30)
                                .foregroundStyle(.gray)
                                .opacity(0.4)
                                .padding(.horizontal, 30)
                                .padding(.bottom)
                            
                            Divider()
                                .padding(.horizontal, 35)
                        }
                        
                        if isFeelingCaptionShowing {
                            Text("느낀점")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            TextField("", text: $viewModel.feelingCaption, axis: .vertical)
                                .padding(.horizontal)
                                .frame(height: 160)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 30)
                                .padding(.bottom, 20)
                                .overlay {
                                    if viewModel.feelingCaption.isEmpty {
                                        Text("생략 가능")
                                            .modifier(ItalicFontModifier())
                                            .font(.caption)
                                            .opacity(0.2)
                                            .padding(.bottom)
                                    }
                                }
                            
                        } else if !isImpressivePhraseShowing && isGenreShowing {
                            Text("느낀점")
                                .fontWeight(.semibold)
                                .opacity(0.5)
                                .padding(.top)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 30)
                                .foregroundStyle(.gray)
                                .opacity(0.4)
                                .padding(.horizontal, 30)
                                .padding(.bottom)
                            
                            Divider()
                                .padding(.horizontal, 35)
                        }
                        
                        if isGenreShowing {
                            VStack {
                                Text("책 장르")
                                    .fontWeight(.semibold)
                                    .padding(.top)
                                
                                Picker("책 장르", selection: $viewModel.genre) {
                                    ForEach(Genre.allCases.dropFirst()) { genre in
                                        Text(genre.rawValue).tag(genre)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .padding(.horizontal, 30)
                            }
                        }
                        
                        if isImpressivePhraseShowing {
                            Button {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    if !viewModel.impressivePhrase.isEmpty {
                                        isImpressivePhraseShowing = false
                                        isFeelingCaptionShowing = true
                                    } else {
                                        isImpressiveAlertShowing = true
                                    }
                                }
                            } label: {
                                if viewModel.impressivePhrase.isEmpty {
                                    Text("다음")
                                        .foregroundStyle(.white)
                                        .frame(width: 110, height: 34)
                                        .background(.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                                        .padding(.bottom, 20)
                                        .padding(.top)
                                } else {
                                    Text("다음")
                                        .foregroundStyle(.white)
                                        .frame(width: 110, height: 34)
                                        .background(Color.sBColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                                        .padding(.bottom, 20)
                                        .padding(.top)
                                }
                            }
                            .alert("비었습니다", isPresented: $isImpressiveAlertShowing) {
                                
                            } message: {
                                Text("인상 깊은 구절은 필수로 작성하셔야 됩니다.")
                            }
                            
                        } else if isFeelingCaptionShowing {
                            ZStack {
                                HStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            isImpressivePhraseShowing = true
                                            isFeelingCaptionShowing = false
                                        }
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .foregroundStyle(Color.sBColor)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 20)
                                            .padding(.top)
                                            .padding(.leading, 50)
                                    }
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            isFeelingCaptionShowing = false
                                            isGenreShowing = true
                                        }
                                    } label: {
                                        Text("다음")
                                            .foregroundStyle(.white)
                                            .frame(width: 110, height: 34)
                                            .background(Color.sBColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                                            .padding(.bottom, 20)
                                            .padding(.top)
                                    }
                                }
                            }
                            
                        } else if isGenreShowing {
                            ZStack {
                                HStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            isFeelingCaptionShowing = true
                                            isGenreShowing = false
                                        }
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .foregroundStyle(Color.sBColor)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 20)
                                            .padding(.top)
                                            .padding(.leading, 50)
                                    }
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Button {
                                        Task {
                                            await viewModel.uploadPost()
                                        }
                                        
                                        navControlTower.popToRoot()
                                        selectedMainTabCapsule.selectedTab = .house
                                    } label: {
                                        Text("작성")
                                            .foregroundStyle(.white)
                                            .frame(width: 110, height: 34)
                                            .background(Color.sBColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                                            .padding(.bottom, 20)
                                            .padding(.top)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .padding(.bottom)
                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                }
            }
            .modifier(BackButtonModifier())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        navControlTower.popToRoot()
                        selectedMainTabCapsule.selectedTab = .house
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.sBColor)
                            .padding(.trailing, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    NewPostUploadPostView(book: Book.DUMMY_BOOK)
        .environment(NavigationControlTower())
        .environment(SelectedMainTabCapsule())
}
