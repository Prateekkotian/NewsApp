//
//  ViewController.swift
//  NewsApp
//
//  Created by Prateek kumar on 10/17/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var mainVM: MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainVM = MainViewModel()
        mainVM?.fetchnews{  isSuccess, error in
            if(isSuccess) {
                print("success")
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            } else {
                print("failure")
            }
        }
    }
}


extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableViewCell.self)") as! CategoryTableViewCell
        let category = mainVM?.categories[indexPath.row]
//        mainVM?.loadImage(imageUrlString: category?.imageUrl ?? "", completion: { [weak self] isLoaded in
//            DispatchQueue.main.async {
        headerCell.configureCell(imageUrl: category?.imageUrl ?? "", name: category?.categoryName ?? "")
//            }
//        })
        return headerCell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let subCategories = mainVM?.categories[indexPath.row].subcategories else { return }
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let subCategoryVC = mainStoryboard.instantiateViewController(withIdentifier: "\(SubCategoryViewController.self)") as! SubCategoryViewController
        subCategoryVC.subCategories = subCategories
        subCategoryVC.title = mainVM?.categories[indexPath.row].categoryName
        self.navigationController?.pushViewController(subCategoryVC, animated: true)
    }
}

