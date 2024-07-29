//
//  ArticleViewModel.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import Foundation
import CoreData

struct ArticleResponse: Codable {
    let response: ArticleDocs
}

struct ArticleDocs: Codable {
    let docs: [Article]
}

struct Article: Codable {
    let abstract: String
    let headline: Headline
    let pubDate: String
    let multimedia: [Multimedia]
    enum CodingKeys: String, CodingKey {
        case abstract
        case headline
        case pubDate = "pub_date"
        case multimedia
    }
    
    func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format of the date string from API
        return dateFormatter.date(from: string)
    }
}


struct Headline: Codable {
    let main: String
}

struct Multimedia: Codable {
    let url: String
}
extension Article {
    init(entity: ArticleEntity) {
        self.abstract = entity.abstract ?? ""
        self.headline = Headline(main: entity.title ?? "")
        self.pubDate = entity.pubDate?.description ?? ""
        if let multimediaData = entity.multimedia {
            self.multimedia = try! JSONDecoder().decode([Multimedia].self, from: multimediaData)
        } else {
            self.multimedia = []
        }
    }
}
