//
//  UrlManager.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}

struct ArticlesEndpoint: Endpoint {
    let baseURL: URL
    let path: String
    let queryItems: [URLQueryItem]
    
    init(query: String, apiKey: String) {
        self.baseURL = URL(string: "https://api.nytimes.com")!
        self.path = "/svc/search/v2/articlesearch.json"
        self.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "api-key", value: apiKey)
        ]
    }
}
