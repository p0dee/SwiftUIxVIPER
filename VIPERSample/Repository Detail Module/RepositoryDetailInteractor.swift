//
//  RepositoryDetailInteractor.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import Combine
import Foundation

class RepositoryDetailInteractor {
    
    let bookmarkListModel: BookmarkListModel
    
    var subscriptions = Set<AnyCancellable>()
    
    init(bookmarkListModel: BookmarkListModel) {
        self.bookmarkListModel = bookmarkListModel
    }
    
    func addBookmark(_ repo: Repository) { //OK?
        bookmarkListModel.add(repo)
    }
    
    func removeBookmark(_ repo: Repository) {
        bookmarkListModel.remove(repo)
    }
    
    func bookmarksContains(_ repo: Repository) -> Bool {
        bookmarkListModel.contains(repo)
    }
    
}
