//
//  UploadPostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI
import Kingfisher

struct NewPostUploadPostView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @Environment(IsPostAddedCapsule.self) var isPostAddedCapsule: IsPostAddedCapsule
    @State private var viewModel: NewPostUploadPostViewModel
    
    @State private var isImpressivePhraseShowing = true
    @State private var isImpressiveAlertShowing = false
    @State private var isFeelingCaptionShowing = false
    @State private var isGenreShowing = false
    
    @FocusState private var focus: NewPostFocusField?
    
    init(book: Book) {
        self.viewModel = NewPostUploadPostViewModel(book: book)
    }
    
    var body: some View {
        GradientBackgroundView {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack {
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
                                    .id("ImpressivePhrase")
                                    .focused($focus, equals: .impressivePhrase)
                                
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
                                Text("캡션")
                                    .fontWeight(.semibold)
                                    .padding(.top)
                                
                                TextField("", text: $viewModel.feelingCaption, axis: .vertical)
                                    .padding(.horizontal)
                                    .frame(height: 160)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 10)
                                    .overlay {
                                        if viewModel.feelingCaption.isEmpty {
                                            Text("생략 가능")
                                                .modifier(ItalicFontModifier())
                                                .font(.caption)
                                                .opacity(0.2)
                                                .padding(.bottom)
                                        }
                                    }
                                    .id("FeelingCaption")
                                    .focused($focus, equals: .feelingCaption)
                                
                            } else if !isImpressivePhraseShowing && isGenreShowing {
                                Text("캡션")
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
                                // 다음
                                Button {
                                    withAnimation(.smooth(duration: 0.4)) {
                                        if !viewModel.impressivePhrase.isEmpty {
                                            isImpressivePhraseShowing = false
                                            isFeelingCaptionShowing = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                withAnimation {
                                                    scrollProxy.scrollTo("FeelingCaption", anchor: .top)
                                                    focus = .feelingCaption
                                                }
                                            }
                                            
                                        } else {
                                            isImpressiveAlertShowing = true
                                        }
                                    }
                                } label: {
                                    if viewModel.impressivePhrase.isEmpty {
                                        Text("다음")
                                            .modifier(InViewButtonModifier(bgColor: .gray))
                                            .padding(.top, 10)
                                        
                                    } else {
                                        Text("다음")
                                            .modifier(InViewButtonModifier(bgColor: .SBTitle))
                                            .padding(.top, 10)
                                    }
                                }
                                .alert("!!", isPresented: $isImpressiveAlertShowing) {
                                    Button {
                                        
                                    } label: {
                                        Text("확인")
                                    }
                                } message: {
                                    Text("인상 깊은 구절은 필수로 작성하셔야 됩니다.")
                                }
                                
                            } else if isFeelingCaptionShowing {
                                ZStack {
                                    // 뒤로가기
                                    HStack {
                                        Button {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                withAnimation(.smooth(duration: 0.4)) {
                                                    isImpressivePhraseShowing = true
                                                    isFeelingCaptionShowing = false
                                                    focus = .impressivePhrase
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10)
                                                .foregroundStyle(Color.SBTitle)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 20)
                                                .padding(.leading, 50)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    // 다음
                                    HStack {
                                        Button {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                withAnimation(.smooth(duration: 0.4)) {
                                                    isFeelingCaptionShowing = false
                                                    isGenreShowing = true
                                                    focus = nil
                                                }
                                            }
                                        } label: {
                                            Text("다음")
                                                .modifier(InViewButtonModifier(bgColor: .SBTitle))
                                        }
                                    }
                                }
                                
                            } else if isGenreShowing {
                                ZStack {
                                    // 뒤로가기
                                    HStack {
                                        Button {
                                            withAnimation(.smooth(duration: 0.4)) {
                                                isFeelingCaptionShowing = true
                                                isGenreShowing = false
                                                focus = .feelingCaption
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    withAnimation {
                                                        scrollProxy.scrollTo("FeelingCaption", anchor: .top)
                                                    }
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10)
                                                .foregroundStyle(Color.SBTitle)
                                                .fontWeight(.bold)
                                                .padding(.bottom, 20)
                                                .padding(.leading, 50)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    // 완료
                                    HStack {
                                        Button {
                                            Task {
                                                await viewModel.uploadPost()
                                                isPostAddedCapsule.isPostAdded = true
                                                navRouter.popToRoot()
                                                mainTabCapsule.selectedTab = .house
                                            }
                                        } label: {
                                            Text("작성")
                                                .modifier(InViewButtonModifier(bgColor: .SBTitle))
                                        }
                                    }
                                }
                            }
                        }
                        .modifier(TileModifier())
                    }
                }
                .modifier(BackModifier())
                .onAppear {
                    focus = .impressivePhrase
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.smooth(duration: 0.4)) {
                            scrollProxy.scrollTo("ImpressivePhrase", anchor: .top)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            navRouter.popToRoot()
                            mainTabCapsule.selectedTab = .house
                        } label: {
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundStyle(Color.SBTitle)
                                .padding(.trailing, 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            focus = .impressivePhrase
        }
    }
}

#Preview {
    NewPostUploadPostView(book: Book.DUMMY_BOOK)
        .environment(NavRouter())
        .environment(MainTabCapsule())
        .environment(IsPostAddedCapsule())
}
