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
    @Published var requestState: RequestState = .succeed
    
    init(interactor: RepositoryListInteractor) {
        self.interactor = interactor
        self.router = RepositoryListRouter()
        
        interactor.searchResultModel.$repos            
            .assign(to: \.searchResult, on: self)
            .store(in: &cancellables)
        interactor.$requestState
            .assign(to: \.requestState, on: self)
            .store(in: &cancellables)
    }
    
    func contentView<LoadingView: View, ContentCellView: View, FailureView: View>(loading: () -> LoadingView, contentCell: @escaping (_ item: Repository) -> ContentCellView, failure: (_ error: APIError) -> FailureView) -> some View {
        Group {
            switch requestState {
            case .succeed:
                ForEach (searchResult, id: \.id) { item in
                    self.navigationLinkForRepositoryDetailView(for: item) {
                        contentCell(item)
                    }
                }
            case .loading:
                loading()
            case .failure(let err):
                failure(err)
            }
        }
    }
    
    func navigationLinkForRepositoryDetailView<Content: View>(for repo: Repository, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.detailView(for: repo, bookmarks: interactor.bookmarkListModel)) {
            content()
        }
    }
    
    func search(ownerName: String) {
        interactor.searchRepository(ownerName: ownerName)
    }
    
}
