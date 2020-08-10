//
//  BookmarkListPresenter.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import Combine
import SwiftUI

class BookmarkListPresenter: ObservableObject {
    
    private let interactor: BookmarkListInteractor
    private let router: BookmarkListRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var bookmarks: [Repository] = []
    
    init(interactor: BookmarkListInteractor) {
        self.interactor = interactor
        self.router = BookmarkListRouter()
        
        interactor.bookmarkListModel.$bookmarks
            .assign(to: \.bookmarks, on: self)
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(for repo: Repository, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.detailView(for: repo, bookmarks: interactor.bookmarkListModel)) {
            content()
        }
    }
    
    func removeBookmarks(at indices: IndexSet) {
        let repos = indices
            .filter { $0 < bookmarks.count }
            .map { bookmarks[$0] }
        repos.forEach { interactor.bookmarkListModel.remove($0) }
    }
    
}

