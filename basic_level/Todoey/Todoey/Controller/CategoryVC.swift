//
//  CategoryVC.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 8.08.2024.
//

import UIKit

class CategoryVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }
    
    func configNavigationBar() {
        navigationItem.title = "Todoey"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [
                //                .kern : 1,
                .foregroundColor : UIColor.white
            ]
            appearance.backgroundColor = .systemCyan
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.compactScrollEdgeAppearance = appearance
        }
    }

    @objc func addButtonTapped() {

        var textField: UITextField?
        let alertController = UIAlertController(title: "Category", message: "Add Category.", preferredStyle: .alert)

        alertController.addTextField()
        textField = alertController.textFields?.first
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //Create NSManagmentObject
        }))
        present(alertController, animated: true)
    }
}
