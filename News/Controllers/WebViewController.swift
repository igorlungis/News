//
//  WebViewController.swift
//  News
//
//  Created by Igor Lungis on 10/21/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit
import WebKit

@available(iOS 13.0, *)
class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: AppDelegate.url!)!))
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

