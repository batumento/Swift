//
//  CategoryCell.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 8.08.2024.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let identifier = "CategoryIdentifier"

    let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    func setupViews() {
        addSubview(categoryName)
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        categoryName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        categoryName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
