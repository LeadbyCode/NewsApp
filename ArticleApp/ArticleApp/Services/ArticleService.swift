//
//  NetworkManager.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation

protocol ArticleServiceProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

class ArticleService: ArticleServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let coreDataArticleService: CoreDataArticleServiceProtocol
    private let apiKey = "j5GCulxBywG3lX211ZAPkAB8O381S5SM"
    
    init(networkService: NetworkServiceProtocol = NetworkService(), coreDataArticleService: CoreDataArticleServiceProtocol = CoreDataArticleService()) {
        self.networkService = networkService
        self.coreDataArticleService = coreDataArticleService
    }
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        let endpoint = ArticlesEndpoint(query: "election", apiKey: apiKey)
        
        networkService.fetchData(from: endpoint) { [weak self] (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let response):
                self?.coreDataArticleService.saveArticles(response.response.docs)
                completion(.success(response.response.docs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

