//
//  MenuModel.swift
//  News
//
//  Created by Igor Lungis on 11/4/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import Foundation
import UIKit

class MenuModelClass {
    
enum MenuModel: Int {
    
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var description: String {
        switch self {
        case .business: return "Бизнес"
        case .entertainment: return "Развлечения"
        case .health: return "Здоровье"
        case .science: return "Наука"
        case .sports: return "Спорт"
        case .technology: return "Технологии"
        }
    }
    
    var url: String {
        switch self {
        case .business: return "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=a06914598e3b4be0a536e78aebd7de71"
        case .entertainment: return "https://newsapi.org/v2/top-headlines?country=ru&category=entertainment&apiKey=a06914598e3b4be0a536e78aebd7de71"
        case .health: return "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=a06914598e3b4be0a536e78aebd7de71"
        case .science: return "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=a06914598e3b4be0a536e78aebd7de71"
        case .sports: return "https://newsapi.org/v2/top-headlines?country=ru&category=sports&apiKey=a06914598e3b4be0a536e78aebd7de71"
        case .technology: return "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=a06914598e3b4be0a536e78aebd7de71"
        }
    }
}
    func getURL(model: MenuModel) -> URL {
        return URL(string: model.url)!
    }
}
