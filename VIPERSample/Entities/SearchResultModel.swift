//
//  DataModel.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import Foundation

class SearchResultModel {
    
    @Published var repos: [Repository] = []
    
}

class BookmarkListModel {
    
    static let shared = BookmarkListModel()
    
    @Published var bookmarks: [Repository] = []
    
    func add(_ repo: Repository) {
        bookmarks.append(repo)
    }
    
    func remove(_ repo: Repository) {
        guard let index = bookmarks.firstIndex(of: repo) else { return }
        bookmarks.remove(at: index)
    }
    
    func contains(_ repo: Repository) -> Bool {
        return bookmarks.contains(repo)
    }
    
}
