//
//  ArticleCell.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    static let cellIdentifier = "ArticleCell"
    static let xibName = "ArticleCell"
    
    var article: Article?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getArticleData(article:Article?) {
        self.article = article
        self.titleLbl.text = article?.headline.main ?? ""
        self.descLbl.text = article?.abstract ?? ""
        self.dateFormate(article?.pubDate ?? "")
    }
    
    private func dateFormate(_ dateString: String) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium // e.g., Jul 10, 2024
            dateFormatter.timeStyle = .short   // e.g., 5:04 PM
            
            self.dateLbl.text = dateFormatter.string(from: date)
        } else {
            print("Invalid date format")
        }
    }
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let imageUrl = "https://www.nytimes.com/" + urlString

        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        
        task.resume()
    }
    
}
