//
//  UploadPostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI
import Kingfisher

struct BookSearchUploadPostView: View {
    @State var viewModel: BookSearchUploadPostViewModel
    
    @Binding var stackActive: Bool
    @Binding var selectedTab: Tab
    
    @State var isImpressivePhraseShowing = true
    @State var isFeelingCaptionShowing = false
    @State var isGenreShowing = false
    
    init(book: Book, stackActive : Binding<Bool>, selectedTab: Binding<Tab>) {
        self.viewModel = BookSearchUploadPostViewModel(book: book)
        self._stackActive = stackActive
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                VStack {
                    Text("글 작성")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    BookCoverView(book: viewModel.book)
                        .padding(.bottom, 10)
                    
                    VStack {
                        if isImpressivePhraseShowing {
                            Text("인상깊은 구절")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            ZStack {
                                TextField("", text: $viewModel.impressivePhrase, axis: .vertical)
                                    .padding(.horizontal)
                                    .frame(height: 160)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.horizontal, 30)
                                
                                if viewModel.impressivePhrase.isEmpty {
                                    Text("큰 따옴표(\")는 자동으로 붙습니다")
                                        .modifier(ItalicFontModifier())
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
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
                                .opacity(0.5)
                                .padding(.horizontal, 30)
                                .padding(.bottom)
                            
                            Divider()
                                .padding(.horizontal, 35)
                        }
                        
                        if isFeelingCaptionShowing {
                            Text("느낀점")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            ZStack {
                                TextField("", text: $viewModel.feelingCaption, axis: .vertical)
                                    .padding(.horizontal)
                                    .frame(height: 160)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 20)
                                
                                if viewModel.feelingCaption.isEmpty {
                                    Text("생략 가능")
                                        .modifier(ItalicFontModifier())
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
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
                                .opacity(0.5)
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
                                    }
                                }
                            } label: {
                                if viewModel.impressivePhrase.isEmpty {
                                    Text("다음")
                                        .foregroundStyle(.white)
                                        .frame(width: 110, height: 34)
                                        .background(.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                        .padding(.bottom, 20)
                                        .padding(.top)
                                } else {
                                    Text("다음")
                                        .foregroundStyle(.white)
                                        .frame(width: 110, height: 34)
                                        .background(Color.sBColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                        .padding(.bottom, 20)
                                        .padding(.top)
                                }
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
                                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
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
                                        stackActive = false
                                        selectedTab = .house
                                    } label: {
                                        Text("작성")
                                            .foregroundStyle(.white)
                                            .frame(width: 110, height: 34)
                                            .background(Color.sBColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
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
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                }
            }
            .modifier(BackButtonModifier())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        stackActive = false
                        selectedTab = .house
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
    BookSearchUploadPostView(book: Book.DUMMY_BOOK, stackActive: .constant(true), selectedTab: .constant(.booksVertical))
}
