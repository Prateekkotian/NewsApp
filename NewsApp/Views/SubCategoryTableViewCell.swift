//
//  SubCategoryTableViewCell.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/17/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var subCategoryImageView: UIImageView!
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    @IBOutlet weak var subCategoryDescriptionLabel: UILabel!
    
    func configureCell(name: String, imageUrl: String, description: String) {
        subCategoryNameLabel.text = name
        subCategoryDescriptionLabel.text = description
        self.loadImage(imageUrlString: imageUrl , completion: { [weak self] isLoaded, image in
            DispatchQueue.main.async {
                self?.subCategoryImageView.image = image
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
