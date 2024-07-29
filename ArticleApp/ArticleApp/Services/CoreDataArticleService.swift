//
//  CoreDataArticleService.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation
import CoreData

class CoreDataArticleService: CoreDataArticleServiceProtocol {
    private let coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
    
    func saveArticles(_ articles: [Article]) {
        let context = coreDataService.context
        articles.forEach { article in
            let entity = ArticleEntity(context: context)
            entity.abstract = article.abstract
            entity.title = article.headline.main
            entity.pubDate = ISO8601DateFormatter().date(from: article.pubDate)
            entity.multimedia = try? JSONEncoder().encode(article.multimedia)
        }
        coreDataService.saveContext()
    }
    
    func fetchLocalArticles() -> [Article] {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "pubDate", ascending: false) // Sort by date in descending order
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let articleEntities = try coreDataService.context.fetch(fetchRequest)
            return articleEntities.map { Article(entity: $0) }
        } catch {
            print("Error fetching local articles: \(error)")
            return []
        }
    }
}
