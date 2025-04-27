//
//  NewPostSearchViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI
import Combine

@Observable
class SearchBookViewModel {
    var bookList = [Book]()
    
    var searchText: String = "" {
        willSet {
            self.searchTextSubject.send(newValue)
        }
    }
    @ObservationIgnored private let searchTextSubject = PassthroughSubject<String, Never>()
    
    var isRedacted = false
    
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    
    init() {
        searchTextSubject
            .debounce(for: 0.5, scheduler: DispatchQueue.global())
            .filter { !$0.isEmpty }
            .sink { [weak self] searchText in
                withAnimation {
                    self?.isRedacted = true
                }
                self?.searchBookWithTitle(searchQuery: searchText)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.isRedacted = false
                }
            }
            .store(in: &cancellables)
    }
    
    private func searchBookWithTitle(searchQuery: String) {
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
