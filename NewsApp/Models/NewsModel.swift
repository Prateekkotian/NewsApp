//
//  NewsModel.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/17/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    
    var categoryId: Int = 0
    var categoryName: String = ""
    var imageUrl: String = ""
    var subcategories: [SubCategoryModel] = []
    
    convenience init(dict: [String: Any]) {
        self.init()
        self.categoryId = dict["CategoryId"] as? Int ?? 0
        self.categoryName = dict["CategoryName"] as?  String ?? ""
        self.imageUrl = dict["ImageUrl"] as? String ?? ""
        guard let subcategories = dict["Subcategories"] as? [[String: Any]] else { return }
        for item in subcategories {
            let subcategory = SubCategoryModel(dict: item)
            self.subcategories.append(subcategory)
        }
    }
}

class SubCategoryModel: NSObject {
    var imageUrl: String = ""
    var subCategoryDescription: String = ""
    var subCategoryId: Int = 0
    var subCategoryName: String = ""
    
    convenience init(dict: [String: Any]) {
        self.init()
        self.imageUrl = dict["ImageUrl"] as? String ?? ""
        self.subCategoryDescription = dict["description"] as? String ?? ""
        self.subCategoryId = dict["subCategoryId"] as? Int ?? 0
        self.subCategoryName = dict["subCategoryName"] as? String ?? ""
    }
}
