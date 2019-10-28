//
//  ViewController.swift
//  News
//
//  Created by Igor Lungis on 10/7/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UITableViewController {
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    var articles: [Article]? = []
    var menuVC: MenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuVC = self.storyboard?.instantiateViewController(identifier: "MenuVC") as? MenuViewController
        
        fetchArticles()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handelSwipe))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handelSwipe))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handelSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            print("Right")
            showMenu()
        case UISwipeGestureRecognizer.Direction.left:
            print("left")
            hideMenu()
        default: break
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageURL) ?? "https://image.flaticon.com/icons/png/512/25/25333.png")
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Singleton.shared.url = self.articles?[indexPath.item].url
    }
    
    @IBAction func menuBarButtonItem(_ sender: UIBarButtonItem) {
        if AppDelegate.isMenuVC {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5) {
            self.menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.isMenuVC = false
        }
    }
           
    func hideMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
    
    @IBAction func refreshControll(_ sender: Any) {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.fetchArticles()
            self.tableView.reloadData()
        }
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

