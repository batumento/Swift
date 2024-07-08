//
//  CustomCell.swift
//  Todoey
//
//  Created by Batuhan Emiroğlu on 2.07.2024.
//

import UIKit

class CustomCell: UITableViewCell {

    static let identifier = "TodoItemIdentifier"

    var descTitle : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label;
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        accessoryView = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        accessoryView?.isHidden = true
        addSubview(descTitle)
        descTitle.translatesAutoresizingMaskIntoConstraints = false
        descTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        descTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
