//
//  MenuModel.swift
//  News
//
//  Created by Igor Lungis on 11/4/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import Foundation
import UIKit

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
    
}
