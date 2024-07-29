//
//  ArticlesViewModelProtocol.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

protocol ArticlesViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    func fetchArticles()
    func numberOfArticles() -> Int
    func article(at index: Int) -> Article
}
