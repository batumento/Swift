//
//  CategoryVC.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 8.08.2024.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    var categoryArray = [Category]()
    let context = DModel.context

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
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

        alertController.addTextField { field in
            field.placeholder = "Add to new category"
        }
        textField = alertController.textFields?.first
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { action in
            guard let safeText = textField?.text else { return }
            let newCategory = Category(context: self.context)
            newCategory.name = safeText
            self.categoryArray.append(newCategory)
            self.saveCategories()
        })
        present(alertController, animated: true)
    }
}

//MARK: - Data Management Methods

extension CategoryVC {

    func saveCategories() {
        do {
            try self.context.save()
        } catch {
            fatalError("Error to saved context: \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try self.context.fetch(request)
        } catch {
            fatalError("Error to request Fetch data: \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - TableView Data Source Methods

extension CategoryVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { fatalError("Tableview not found CategoryCell") }
        let category = categoryArray[indexPath.row]
        cell.categoryName.text = category.name
        return cell
    }
}

//MARK: - TableView Delegate Methods

extension CategoryVC {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoListVC()
        vc.selectedCategory = categoryArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
