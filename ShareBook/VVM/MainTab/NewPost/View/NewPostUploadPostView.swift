//
//  UploadPostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/5/24.
//

import SwiftUI
import Kingfisher

struct NewPostUploadPostView: View {
    @State var viewModel: NewPostUploadPostViewModel
    
    @Binding var stackActive: Bool
    @Binding var selectedTab: Tab
    
    init(book: Book, stackActive : Binding<Bool>, selectedTab: Binding<Tab>) {
        self.viewModel = NewPostUploadPostViewModel(book: book)
        self._stackActive = stackActive
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("글 작성")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                BookCoverView(book: viewModel.book)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack {
                        Text("인상깊은 구절")
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        ZStack {
                            TextField("", text: $viewModel.impressivePhrase, axis: .vertical)
                                .padding(.horizontal)
                                .frame(height: 180)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 30)
                            
                            if viewModel.impressivePhrase.isEmpty {
                                Text("\"네 장미꽃을 그렇게 소중하게 만든 것은 \n그 꽃을 위해 네가 소비한 시간이란다\"")
                                    .modifier(ItalicFontModifier())
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .opacity(0.2)
                                    .padding(.bottom, 70)
                                    .padding(.top, 40)
                                Text("- 어린왕자")
                                    .modifier(ItalicFontModifier())
                                    .font(.caption)
                                    .opacity(0.1)
                                    .padding(.top, 30)
                            }
                        }
                        
                        Text("간략한 소감 (생략 가능)")
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        TextField("", text: $viewModel.feelingCaption, axis: .vertical)
                            .padding(.horizontal)
                            .frame(height: 180)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        
                        Button {
                            Task {
                                await viewModel.uploadPost()
                            }
                            stackActive = false
                            selectedTab = .house
                        } label: {
                            Text("작성")
                                .foregroundStyle(.white)
                                .frame(height: 34)
                                .frame(maxWidth: .infinity)
                                .background(Color.sBColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                .padding(.horizontal, 130)
                                .padding(.bottom, 20)
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .padding(.bottom)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                }
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

#Preview {
    NewPostUploadPostView(book: Book.DUMMY_BOOK, stackActive: .constant(true), selectedTab: .constant(.plusSquareOnSquare))
}
