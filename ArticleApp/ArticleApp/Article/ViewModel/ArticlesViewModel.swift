//
//  ArticlesViewModel.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation

class ArticlesViewModel: ArticlesViewModelProtocol {
    var reloadTableView: (() -> Void)?
    private let articleService: ArticleServiceProtocol
    private let coreDataArticleService: CoreDataArticleServiceProtocol
    private(set) var articles: [Article] = []
    
    
    init(articleService: ArticleServiceProtocol = ArticleService(), coreDataArticleService: CoreDataArticleServiceProtocol = CoreDataArticleService()) {
        self.articleService = articleService
        self.coreDataArticleService = coreDataArticleService
    }
    func fetchArticles() {
        articleService.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                
                self?.articles = articles
                self?.articles.sort { ($0.date(from: $0.pubDate) ?? Date.distantPast) > ($1.date(from: $1.pubDate) ?? Date.distantPast) }

                self?.reloadTableView?()
            case .failure(let error):
                print("Error fetching articles: \(error)")
                self?.articles = self?.coreDataArticleService.fetchLocalArticles() ?? []
                self?.articles.sort { ($0.date(from: $0.pubDate) ?? Date.distantPast) > ($1.date(from: $1.pubDate) ?? Date.distantPast) }

                self?.reloadTableView?()
            }
        }
    }

    func numberOfArticles() -> Int {
        return articles.count
    }

    func article(at index: Int) -> Article {
        return articles[index]
    }
}
