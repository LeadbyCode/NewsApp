//
//  CoreDataProtocols.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
}

protocol CoreDataArticleServiceProtocol {
    func saveArticles(_ articles: [Article])
    func fetchLocalArticles() -> [Article]
}
