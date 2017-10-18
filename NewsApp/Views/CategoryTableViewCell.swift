//
//  CategoryTableViewCell.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/17/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configureCell(imageUrl: String, name: String) {
        self.categoryNameLabel.text = name
        self.loadImage(imageUrlString: imageUrl , completion: { [weak self] isLoaded, image in
            DispatchQueue.main.async {
                self?.categoryImageView.image = image
            }
        })
    }
    
    func loadImage(imageUrlString: String, completion: @escaping (_ isLoaded: Bool, _ image: UIImage) -> Void) {
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: TimeInterval(20))
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (responseData, urlResponse, error) in
            print(error?.localizedDescription ?? "")
            guard urlResponse != nil, let imageData = responseData else {
                return
            }
            guard let image = UIImage(data: imageData) else { return }
            completion(true, image)
            }.resume()
    }
}
