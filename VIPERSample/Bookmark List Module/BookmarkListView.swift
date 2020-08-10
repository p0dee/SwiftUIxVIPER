//
//  BookmarkListView.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import SwiftUI

struct BookmarkListView: View {
    
    @ObservedObject var presenter: BookmarkListPresenter
    
    var body: some View {
        NavigationView {
            VStack {
                if presenter.bookmarks.count > 0 {
                    List {
                        ForEach(presenter.bookmarks, id: \.id) { item in
                            presenter.linkBuilder(for: item) {
                                Cell(ownerName: item.owner.login, repositoryName: item.name,
                                     description: item.description)
                            }
                        }
                        .onDelete { indexSet in
                            presenter.removeBookmarks(at: indexSet)
                        }
                    }
                } else {
                    Text("No bookmarks")
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
    
}

extension BookmarkListView {
    
    struct Cell: View {
        
        let ownerName: String
        let repositoryName: String
        let description: String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 3) {
                Text(ownerName + "/")
                    .font(.body)
                    .foregroundColor(.primary)
                Text(repositoryName)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                if let description = description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .multilineTextAlignment(.leading)
        }
        
    }
    
}
