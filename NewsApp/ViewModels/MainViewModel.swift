//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/17/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class MainViewModel {
    
    var categories: [CategoryModel] = []
    var subCategories: [SubCategoryModel] = []
    var image: UIImage?
    
    public init() {}
    
    func fetchnews(completion: @escaping (_ isSucees: Bool, _ error: String) -> Void) {
        guard let url = URL(string: "https://s3.amazonaws.com/recruiting-test/ios/category.json") else { return }
        let requets = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: requets, completionHandler: {  [weak self] data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                do {
                    guard let safeData = data else { return }
                    guard let news = try JSONSerialization.jsonObject(with: safeData, options: []) as? [[String: Any]] else {
                        print("error, while trying to convert data to JSON")
                        return
                    }
                    for item in news {
                        let category = CategoryModel(dict: item)
                        self?.categories.append(category)
                    }
                    completion(true, "")
                } catch {
                    print("error, while trying to convert data to JSON")
                    return
                }
            }
        })
        task.resume()
    }
}
