//
//  RepositoryDetailView.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/01.
//

import SwiftUI
import WebKit

struct RepositoryDetailView: View {
    
    let repository: Repository
    
    @ObservedObject var presenter: RepositoryDetailPresenter
    
    var body: some View {
        WebView(initialURL: URL(string: "https://apple.com")!)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(repository.name)
            .navigationBarItems(trailing: Button {
                if presenter.bookmarksContains(repository) {
                    presenter.removeBookmark(repository)
                } else {
                    presenter.addBookmark(repository)
                }
            } label: {
                Image(systemName: presenter.shouldHighlightBookmarkButton() ? "bookmark.fill" :  "bookmark")
            })
    }
    
}

struct WebView: UIViewRepresentable {
    
    let initialURL: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.url == nil {
            uiView.load(.init(url: initialURL))
        }
    }

    
}
