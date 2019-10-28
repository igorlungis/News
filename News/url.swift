//
//  url.swift
//  News
//
//  Created by Igor Lungis on 10/23/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//


class Singleton {
    static let shared = Singleton()
    var url: String?
    var globalUrl = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=a06914598e3b4be0a536e78aebd7de71"
}
