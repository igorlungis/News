//
//  MenuViewController.swift
//  News
//
//  Created by Igor Lungis on 10/28/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//


import UIKit

@available(iOS 13.0, *)
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!

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
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId) as! MenuTableViewCell
        let menuModel = MenuModelClass.MenuModel(rawValue: indexPath.row)
        cell.myLabel.text = menuModel?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuModel = MenuModelClass.MenuModel(rawValue: indexPath.row)
        let menuModelClass = MenuModelClass()
        AppDelegate.globURL = menuModelClass.getURL(model: menuModel!)
        AppDelegate.naviTitle = menuModel!.description
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggle"), object: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

