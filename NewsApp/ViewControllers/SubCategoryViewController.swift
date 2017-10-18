//
//  SubCategoryViewController.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/18/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {
    
    var subCategories = [SubCategoryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SubCategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SubCategoryTableViewCell.self)", for: indexPath) as! SubCategoryTableViewCell
        let subCategory = subCategories[indexPath.row]
        cell.configureCell(name: subCategory.subCategoryName, imageUrl: subCategory.imageUrl, description: subCategory.subCategoryDescription)
        return cell
    }
}
