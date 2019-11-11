//
//  ViewController.swift
//  News
//
//  Created by Igor Lungis on 10/7/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var jsonData: NewsApiModel?
    
    private let myRefreshControl: UIRefreshControl = {
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
        self.fetchArticles()
        self.navigationBar.title = AppDelegate.naviTitle
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        self.fetchArticles()
        sender.endRefreshing()
    }
    
    private func fetchArticles() {
        
        let task = URLSession.shared.dataTask(with: AppDelegate.globURL!) { (data, response, error) in
            if error != nil {
                print("URL ERROR -->>>", error!)
                return
            }
            do {
                let json = try JSONDecoder().decode(NewsApiModel.self, from: data!)
                self.jsonData = json
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                } catch let error {
                    print("JSON ERROR -->>>", error)
                }
        }
        task.resume()
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
      
        cell.title.text = self.jsonData?.articles![indexPath.item].title ?? ""
        cell.desc.text = self.jsonData?.articles![indexPath.item].description ?? ""
        cell.author.text = self.jsonData?.articles![indexPath.item].author ?? ""

        if self.jsonData?.articles![indexPath.item].urlToImage != nil {
                   cell.imgView.downloadImage(from: (self.jsonData?.articles![indexPath.item].urlToImage)!)
               } else {
                   cell.imgView.image = UIImage(named: "noImage.png")
               }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonData?.articles!.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = storyboard!.instantiateViewController(withIdentifier: "web") as! WebViewController
        webVC.url = self.jsonData?.articles![indexPath.item].url
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
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

