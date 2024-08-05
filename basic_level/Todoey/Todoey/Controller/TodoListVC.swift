//
//  ViewController.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 2.07.2024.
//

import UIKit

class TodoListVC: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Items.plist", directoryHint: .notDirectory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadItems()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        configNavigationBar()
    }
    
    func configNavigationBar() {
        navigationItem.title = "Todoey"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.titleView?.tintColor = .systemPink
        
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
        var textField : UITextField?
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            guard let safeTextField = textField else { return }
            self.itemArray.append(Item(title: safeTextField.text!, check: false))
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func saveItems() {
        let encode = PropertyListEncoder()
        
        do {
            let data = try encode.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            fatalError("Not Encode Item for .plist format: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: dataFilePath!)
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch {
            fatalError("Error for can't decode from url: \(error)")
        }
    }
}

//MARK: - Tableview Datasources Methods

extension TodoListVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { fatalError("The Tableview could not dequeue a Cell in VC")}
        let item = itemArray[indexPath.row]
        
        cell.descTitle.text = item.title
        cell.accessoryView?.isHidden = !item.check
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
        selectItem.check = !selectItem.check
        saveItems()
    }
}
