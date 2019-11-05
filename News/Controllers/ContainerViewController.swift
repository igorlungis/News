//
//  ContainerViewController.swift
//  News
//
//  Created by Igor Lungis on 10/30/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class ContainerViewController: UIViewController {
    
    var controller: UIViewController!
    var menuViewController: UIViewController!
    var isMove = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: NSNotification.Name(rawValue: "toggle"), object: nil)
    }
    
    func configureViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        controller = viewController
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            print("menuVC create")
        }
    }
    
    func showMenuVC(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width * 0.4
            }) { (finished) in }
        } else {
          UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                                self.controller.view.frame.origin.x = 0
            }) { (finished) in
            }
        }
    }
    
    @objc func toggleMenu() {
        configureMenuViewController()
        isMove = !isMove
        showMenuVC(shouldMove: isMove)
        print(isMove)
    }
}
