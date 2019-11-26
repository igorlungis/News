//
//  ArticleCell.swift
//  News
//
//  Created by Igor Lungis on 10/14/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    var imageCache = NSCache<NSString, UIImage>()
    private weak var imageTask: URLSessionDataTask?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imgView.image = nil
    }
        
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {

        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        }  else {
            let request = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                self!.imageCache.setObject(image, forKey: url as NSString)

                DispatchQueue.main.async {
                    completion(image)
                }
            }
            imageTask = dataTask
            dataTask.resume()
        }
    }
}
