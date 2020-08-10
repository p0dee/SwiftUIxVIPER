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
    
    init(searchResultModel: SearchResultModel, bookmarkListModel: BookmarkListModel) {
        self.searchResultModel = searchResultModel
        self.bookmarkListModel = bookmarkListModel
    }
    
    func searchRepository(ownerName: String) {
        RepoSearchAPI(username: ownerName)
            .request()
            .replaceError(with: [.init(id: 0, name: "Failure", description: "Failure", owner: .init(login: ""))])
            .receive(on: RunLoop.main)
            .sink { [weak self] (repos) in
                guard let self = self else { return }
                self.searchResultModel.repos = repos
            }
            .store(in: &subscriptions)
    }        
    
}

struct RepoSearchAPI {
    
    struct SomeError: Error { }
    
    let username: String
//
//    private var cancellable: Cancellable? {
//        didSet {
//            oldValue?.cancel()
//        }
//    }
    
    func request() -> AnyPublisher<[Repository], SomeError>{
        let urlString = "https://api.github.com/users/\(username)/repos"
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let item = URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .mapError({ err in
                return SomeError()
            })
            .eraseToAnyPublisher()
        return item
    }
    
}
