//
//  NumberInputView.swift
//  Calculator_Constraint
//
//  Created by Batuhan Emiroğlu on 10.07.2024.
//

import UIKit

class NumberInputView: UIStackView {

    enum RowType {
        case first
        case normal
        case last
    }

    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()

    
    init(rowType: RowType, input1: Character, input2: String, input3: Character, input4: Character?) {
        button1.setTitle(String(input1), for: .normal)
        button2.setTitle(String(input2), for: .normal)
        button3.setTitle(String(input3), for: .normal)
        button4.setTitle(String(input4 ?? " "), for: .normal)
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 1

        addArrangedSubview(button1)
        addArrangedSubview(button2)
        addArrangedSubview(button3)
        addArrangedSubview(button4)

        
        switch rowType {
        case .first:
            for (index,view) in arrangedSubviews.enumerated() {
                if let button = view as? UIButton {
                    button.titleLabel?.font = .systemFont(ofSize: 25)
                    if index == 3 {
                        button.backgroundColor = .systemOrange
                        button.setTitleColor(.white, for: .normal)
                        continue
                    }
                    button.backgroundColor = .lightGray
                    button.setTitleColor(.black, for: .normal)
                }
            }
        case .normal:
            for (index,view) in arrangedSubviews.enumerated() {
                if let button = view as? UIButton {
                    button.titleLabel?.font = .systemFont(ofSize: 25)
                    if index == 3 {
                        button.backgroundColor = .systemOrange
                        button.titleLabel?.textColor = .white
                        continue
                    }
                    button.backgroundColor = .darkGray
                    button.titleLabel?.textColor = .white
                }
            }
        case .last:
            removeArrangedSubview(button4)
            let stackView = UIStackView()
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.axis = .horizontal
            stackView.spacing = 1
            addArrangedSubview(stackView)
            for (index,view) in arrangedSubviews.enumerated() {
                if let button = view as? UIButton {
                    button.titleLabel?.font = .systemFont(ofSize: 25)
                    if index >= 1 {
                        stackView.addArrangedSubview(button)
                        if index == 2 {
                            button.backgroundColor = .systemOrange
                            button.titleLabel?.textColor = .white
                            removeArrangedSubview(button3)
                            removeArrangedSubview(button2)
                            continue
                        }
                    }
                    button.backgroundColor = .darkGray
                    button.titleLabel?.textColor = .white
                }
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
