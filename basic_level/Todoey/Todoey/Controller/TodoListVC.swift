//
//  ViewController.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 2.07.2024.
//

import UIKit

class TodoListVC: UITableViewController {

    let itemArray = ["Example Eggs", "Example Somon", "Example Cugs"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        view.backgroundColor = .systemBackground
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
        print("Exams")
    }
}

    //MARK: - Tableview Datasources Methods

extension TodoListVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { fatalError("The Tableview could not dequeue a Cell in VC")}
        cell.descTitle.text = itemArray[indexPath.row]
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
        tableView.cellForRow(at: indexPath)?.accessoryView?.isHidden = !(tableView.cellForRow(at: indexPath)?.accessoryView?.isHidden ?? false)
        print(itemArray[indexPath.row])
        
    }
}
