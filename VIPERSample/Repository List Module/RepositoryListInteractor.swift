//
//  RepositoryListInteractors.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import Combine
import Foundation

class RepositoryListInteractor {
    
    let searchResultModel: SearchResultModel
    
    let bookmarkListModel: BookmarkListModel
    
    var subscriptions = Set<AnyCancellable>()
    
    //    private var cancellable: Cancellable? {
    //        didSet {
    //            oldValue?.cancel()
    //        }
    //    }
    
    @Published var requestState: RequestState = .succeed
    
    init(searchResultModel: SearchResultModel, bookmarkListModel: BookmarkListModel) {
        self.searchResultModel = searchResultModel
        self.bookmarkListModel = bookmarkListModel
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
