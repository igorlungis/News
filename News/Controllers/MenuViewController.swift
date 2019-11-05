////
////  MenuViewController.swift
////  News
////
////  Created by Igor Lungis on 10/28/19.
////  Copyright © 2019 Igor Lungis. All rights reserved.
////


import UIKit
protocol MenuDelegate {
    func toggleMenu2()
}

@available(iOS 13.0, *)
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var menuDelegate: MenuDelegate?
    let menuTitle = ["Бизнес", "Развлечения", "Здоровье", "Наука", "Спорт", "Технологии"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseId)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0.4750230908, blue: 0.453597486, alpha: 1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId) as! MenuTableViewCell
        let menuModel = MenuModel(rawValue: indexPath.row)
        cell.myLabel.text = menuModel?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=a06914598e3b4be0a536e78aebd7de71"
            print("1 cell")
        case 1: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=entertainment&apiKey=a06914598e3b4be0a536e78aebd7de71"
        print("2 cell")
        case 2: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=a06914598e3b4be0a536e78aebd7de71"
        print("3 cell")
        case 3: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=a06914598e3b4be0a536e78aebd7de71"
        print("4 cell")
        case 4: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=sports&apiKey=a06914598e3b4be0a536e78aebd7de71"
        print("5 cell")
        case 5: AppDelegate.globURL = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=a06914598e3b4be0a536e78aebd7de71"
        print("6 cell")
        default:
            break
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggle"), object: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

