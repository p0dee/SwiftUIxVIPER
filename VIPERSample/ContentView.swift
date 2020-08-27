//
//  ContentView.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import SwiftUI

/*
 TODO:
 
 
 Web URL
 Persistence
 */

struct ContentView: View {
    var body: some View {
        TabView {
            RepositoryListView(
                presenter: .init(
                    interactor: RepositoryListInteractor(
                        searchResultModel: SearchResultModel(),
                        bookmarkListModel: BookmarkListModel.shared
                    )
                )
            )
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            BookmarkListView(
                presenter: .init(
                    interactor: BookmarkListInteractor(
                        bookmarkListModel: BookmarkListModel.shared
                    )
                )
            )
            .tabItem {
                Image(systemName: "bookmark.fill")
                Text("Bookmarks")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
