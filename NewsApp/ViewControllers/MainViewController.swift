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
        fetchNews()
    }
    
    private func fetchNews() {
        mainVM?.fetchnews{ [weak self]  isSuccess, error in
            if(isSuccess) {
                print("success")
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
            } else {
                self?.showAlert(message: error)
            }
        }
    }
    
    private func showAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableViewCell.self)") as! CategoryTableViewCell
        cell.selectionStyle = .none
        let category = mainVM?.categories[indexPath.row]
        cell.configureCell(imageUrl: category?.imageUrl ?? "", name: category?.categoryName ?? "")
        return cell
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

