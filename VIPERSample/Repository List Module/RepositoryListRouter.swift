//
//  RepositoryListRouter.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import SwiftUI

class RepositoryListRouter {
    
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
