//
//  ViewController.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 2.07.2024.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.keyboardAppearance = .default
        return searchBar
    }()
    
    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    let context = DModel.context
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchBar.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        configNavigationBar()
    }

    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }

    func configNavigationBar() {
        navigationItem.title = "Item"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func addButtonTapped() {
        var textField : UITextField?
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            guard let safeTextField = textField else { return }
            let newItem = Item(context: self.context)
            newItem.title = safeTextField.text
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - Data Management Methods

extension TodoListVC {
    
    func saveItems() {
        do {
            try self.context.save()
        }
        catch {
            fatalError("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        do {
            itemArray = try context.fetch(request)
        } catch {
            fatalError("Not load items: \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Tableview Datasources Methods

extension TodoListVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { fatalError("The Tableview could not dequeue a Cell in VC")}
        let item = itemArray[indexPath.row]
        
        cell.descTitle.text = item.title
        cell.accessoryView?.isHidden = !item.done
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
}

//MARK: - Tableview Delegates Methods

extension TodoListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectItem = itemArray[indexPath.row]
        selectItem.done = !selectItem.done
        saveItems()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let detailAction = UIContextualAction(style: .normal, title: "Details", handler: { action, view, completionHandler in
            view.backgroundColor = .systemGray
            completionHandler(true)
        })
        detailAction.backgroundColor = .systemGreen
        detailAction.image = UIImage(systemName: "square.and.arrow.down.on.square")
        
        let portugalAction = UIContextualAction(style: .normal, title: "Portugal", handler: { action, view, completionHandler in
            self.context.delete(self.itemArray[indexPath.row])
            self.itemArray.remove(at: indexPath.row)
            self.saveItems()
            action.image = UIImage(systemName: "square.and.arrow.down.on.square")
            completionHandler(true)
        })
        portugalAction.backgroundColor = .systemRed
        portugalAction.image = UIImage(systemName: "eraser.fill")
        let actions = UISwipeActionsConfiguration(actions: [detailAction, portugalAction])
        return actions
    }
}

//MARK: - UISearchBarDelegate

extension TodoListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
}
