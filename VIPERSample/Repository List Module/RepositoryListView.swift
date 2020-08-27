//
//  RepositoryListView.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject var presenter: RepositoryListPresenter
    
    var body: some View {
        NavigationView {
            VStack {
                SearchFiled(presenter: presenter)
                    .padding()
                List {
                    switch presenter.requestState {
                    case .succeed:
                        ForEach (presenter.searchResult, id: \.id) { item in
                            presenter.linkBuilder(for: item) {
                                Cell(repositoryName: item.name,
                                     description: item.description,
                                     isBookmarked: true)
                            }
                        }
                    case .loading:
                        Text("Loading...").layoutPriority(-1)
                    case .failure(let err):
                        Text(err.message)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
}

extension RepositoryListView {
    
    struct Cell: View {
        
        let repositoryName: String
        let description: String?
        let isBookmarked: Bool
        
        var body: some View {
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                VStack(alignment: .leading, spacing: 3) {
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

    struct SearchFiled: View {
        
        @State var fieldValue: String = ""
        var presenter: RepositoryListPresenter
        
        var body: some View {
            HStack {
                TextField("Search repos with user name", text: $fieldValue)
                    .autocapitalization(.none)
                    .keyboardType(.alphabet)
                Button("Search") {
                    presenter.search(ownerName: fieldValue)
                }
            }
            .padding()
            .background(Color(white: 0.9))
            .cornerRadius(8)
        }
        
    }
    
}
