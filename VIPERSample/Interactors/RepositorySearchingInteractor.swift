//
//  RepositorySearchInteractor.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/13.
//

import Combine
import Foundation

class RepositorySearchingInteractor {
    
    let searchResultModel: SearchResultModel
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var requestState: RequestState = .succeed
    
    init(searchResultModel: SearchResultModel, bookmarkListModel: BookmarkListModel) {
        self.searchResultModel = searchResultModel
    }
    
    func searchRepository(ownerName: String) {
        requestState = .loading
        RepoSearchAPI(username: ownerName)
            .request()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.requestState = .succeed
                case .failure(let err):
                    self.requestState = .failure(error: err)
                }
            }, receiveValue: ({ [weak self] repos in
                guard let self = self else { return }
                self.searchResultModel.repos = repos
            }))
            .store(in: &subscriptions)
    }
    
}
