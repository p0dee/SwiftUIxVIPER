//
//  BookmarkListRouter.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import SwiftUI

class BookmarkListRouter {
    
    func detailView(for repo: Repository, bookmarks: BookmarkListModel) -> some View {
        RepositoryDetailView(
            repository: repo,
            presenter: RepositoryDetailPresenter(
                repository: repo,
                interactor: RepositoryDetailInteractor(
                    bookmarkListModel: bookmarks
                )
            )
        )
    }
    
}
