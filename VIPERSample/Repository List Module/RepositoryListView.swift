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
                SearchFiled(placeholder: "Search repos with user name") { fieldValue in
                    presenter.search(ownerName: fieldValue)
                }
                    .padding()
                List {
                    presenter.contentView(loading: {
                        Text("Loading...")
                    }, contentCell: { item in
                        Cell(repositoryName: item.name,
                             description: item.description,
                             isBookmarked: true)
                    }, failure: { error in
                        Text(error.message)
                    })
                }
            }
            .navigationBarHidden(true)
        }
    }
    
}

private extension RepositoryListView {
    
    struct Cell: View {        
        
        let repositoryName: String
        let description: String?
        let isBookmarked: Bool
        
        var body: some View {
            HStack(alignment: .firstTextBaseline, spacing: 3) {
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
        
        let placeholder: String
        let searchButtonAction: (_ fieldValie: String) -> Void
        
        @State var fieldValue: String = ""
        
        var body: some View {
            HStack {
                TextField(placeholder, text: $fieldValue)
                    .autocapitalization(.none)
                    .keyboardType(.alphabet)
                Button("Search") {
                    searchButtonAction(fieldValue)
                }
            }
            .padding()
            .background(Color(white: 0.9))
            .cornerRadius(8)
        }
        
    }
    
}
