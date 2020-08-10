//
//  RepositoryDetailPresenter.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import Combine
import SwiftUI

class RepositoryDetailPresenter: ObservableObject {
    
    private let interactor: RepositoryDetailInteractor
    private let router: RepositoryDetailRouter
    
    private let repository: Repository
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var bookmarks: [Repository] = []
    
    init(repository: Repository, interactor: RepositoryDetailInteractor) {
        self.interactor = interactor
        self.router = RepositoryDetailRouter()
        self.repository = repository
        
        interactor.bookmarkListModel.$bookmarks
            .assign(to: \.bookmarks, on: self)
            .store(in: &cancellables)
    }
    
    func shouldHighlightBookmarkButton() -> Bool {
        bookmarks.contains(repository)
    }
    
    func addBookmark(_ repo: Repository) {
        interactor.addBookmark(repo)
    }
    
    func removeBookmark(_ repo: Repository) {
        interactor.removeBookmark(repo)
    }
    
    func bookmarksContains(_ repo: Repository) -> Bool {
        interactor.bookmarksContains(repo)
    }
    
}
