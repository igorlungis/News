//
//  WebViewController.swift
//  News
//
//  Created by Igor Lungis on 10/21/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: Singleton.shared.url!)!))
    }
}
