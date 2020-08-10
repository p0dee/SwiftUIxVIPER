//
//  RepositoryListPresenter.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import Combine
import SwiftUI

class RepositoryListPresenter: ObservableObject {
    
    private let interactor: RepositoryListInteractor
    private let router: RepositoryListRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchResult: [Repository] = []
    @Published var bookmarks: [Repository] = []
    
    init(interactor: RepositoryListInteractor) {
        self.interactor = interactor
        self.router = RepositoryListRouter()        
        interactor.searchResultModel.$repos            
            .assign(to: \.searchResult, on: self)
            .store(in: &cancellables)

    }
    
    func linkBuilder<Content: View>(for repo: Repository, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.detailView(for: repo, bookmarks: interactor.bookmarkListModel)) {
            content()
        }
    }
    
    func search(ownerName: String) {
        interactor.searchRepository(ownerName: ownerName)
    }
    
}
