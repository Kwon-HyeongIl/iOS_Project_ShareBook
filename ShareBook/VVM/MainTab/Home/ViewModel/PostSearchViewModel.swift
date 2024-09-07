//
//  PostSearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/7/24.
//

import SwiftUI

@Observable
class PostSearchViewModel {
    var posts: [Post] = []
    
    @ObservationIgnored let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    func searchPostByBookName(searchText: String) async {
        self.posts = await PostManager.searchPostByBookName(searchText: searchText)
    }
    
    func resizePost(proxyWidth: CGFloat) -> CGFloat {
        return 17 + ((proxyWidth - 393) * (0.4))
    }
}
