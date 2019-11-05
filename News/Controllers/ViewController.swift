//
//  ViewController.swift
//  News
//
//  Created by Igor Lungis on 10/7/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]? = []
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles()
        tableView.refreshControl = myRefreshControl
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    @objc func reload() {
        DispatchQueue.main.async {
          self.fetchArticles()
          self.tableView.reloadData()
        }
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.fetchArticles()
            self.tableView.reloadData()
                sender.endRefreshing()
          }
    }
    
    func fetchArticles() {
        
        let urlRequst = URLRequest(url: URL(string: AppDelegate.globURL)!)
        let task = URLSession.shared.dataTask(with: urlRequst) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                         if let title = articleFromJson["title"],
                            let author = articleFromJson["author"],
                            let desc = articleFromJson["description"],
                            let url = articleFromJson["url"],
                            let urlToImage = articleFromJson["urlToImage"]{
                            article.author = author as? String
                                article.desc = desc as? String
                                article.headline = title as? String
                                article.url = url as? String
                                article.imageURL = urlToImage as? String
                        }
                        self.articles?.append(article)
                    }
                }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                } catch let error {
                    print(error)
                }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageURL) ?? "https://image.flaticon.com/icons/png/512/25/25333.png")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.url = self.articles?[indexPath.item].url
  
        let webVC = storyboard!.instantiateViewController(withIdentifier: "web") as! WebViewController
        webVC.modalTransitionStyle = .flipHorizontal
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
    @IBAction func menuButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggle"), object: nil)
    }
    

}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

