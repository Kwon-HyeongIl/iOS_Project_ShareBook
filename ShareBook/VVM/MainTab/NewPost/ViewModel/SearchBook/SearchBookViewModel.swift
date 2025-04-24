//
//  NewPostSearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import Foundation
import Combine

@Observable
class SearchBookViewModel {
    var bookList = [Book]()
    
    var searchText = ""
    var isRedacted = false
    var isShowing = true
    
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    
    func searchBookWithTitle(searchQuery: String) {
        BookManager.requestSearchBookList(searchQuery: searchQuery)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Book API Success")
                case .failure(let error):
                    print("Book API Failed: \(error)")
                }
            } receiveValue: { [weak self] data in
                self?.bookList = data
            }
            .store(in: &cancellables)
    }
}
