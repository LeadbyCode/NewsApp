//
//  ViewController.swift
//  ArticleApp
//
//  Created by Nilesh Vernekar on 29/07/24.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var articles: [Article] = []
    private var viewModel: ArticlesViewModelProtocol = ArticlesViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ArticleCell.xibName, bundle: nil), forCellReuseIdentifier: ArticleCell.cellIdentifier)
        fetchArticles()
    }
    

    private func fetchArticles() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchArticles()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return  viewModel.numberOfArticles()
      }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.cellIdentifier, for: indexPath) as? ArticleCell {
            let article = viewModel.article(at: indexPath.row)
            cell.getArticleData(article: article)
            if let imageUrl = article.multimedia.first?.url {
                cell.loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        cell.articleImage.image = image
                        cell.setNeedsLayout()
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }

}
