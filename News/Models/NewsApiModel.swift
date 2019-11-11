//
//  Article.swift
//  News
//
//  Created by Igor Lungis on 10/14/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

struct NewsApiModel: Decodable {
    
    var status: String?
    var totalResults: Int?
    var articles: [Articles]?
    
}


