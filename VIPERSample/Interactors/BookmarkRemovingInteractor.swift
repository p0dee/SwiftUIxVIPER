//
//  RemoveBookmarkInteractor.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/13.
//

import Combine
import Foundation

class BookmarkRemovingInteractor {
    
    let bookmarkListModel: BookmarkListModel

    var subscriptions = Set<AnyCancellable>()

    init(bookmarkListModel: BookmarkListModel) {
        self.bookmarkListModel = bookmarkListModel
    }

    func removeBookmark(_ repo: Repository) {
        bookmarkListModel.remove(repo)
    }

    func bookmarksContains(_ repo: Repository) -> Bool {
        bookmarkListModel.contains(repo)
    }
    
}
