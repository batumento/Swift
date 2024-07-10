//
//  ViewController.swift
//  Calculator_Constraint
//
//  Created by Batuhan Emiroğlu on 10.07.2024.
//

import UIKit

class ViewController: UIViewController {

    let numberLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 60)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 2
        label.text = "50"
        return label
    }()

    var portraitConstraint = NSLayoutConstraint()
    var landSpaceConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UIDevice.current.orientation.isLandscape {
            portraitConstraint.isActive = false
            landSpaceConstraint.isActive = true
        }
        else {
            portraitConstraint.isActive = true
            landSpaceConstraint.isActive = false
        }
    }

    func setupViews() {
        let numberStackView : UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 1
            stackView.alignment = .fill
            return stackView
        }()

        let inputStackView1 = NumberInputView(rowType: .first, input1: "C", input2: "+/-", input3: "%", input4: "÷")
        let inputStackView2 = NumberInputView(rowType: .normal, input1: "7", input2: "8", input3: "9", input4: "x")
        let inputStackView3 = NumberInputView(rowType: .normal, input1: "4", input2: "5", input3: "6", input4: "÷")
        let inputStackView4 = NumberInputView(rowType: .normal, input1: "1", input2: "2", input3: "3", input4: "÷")
        let inputStackView5 = NumberInputView(rowType: .last, input1: "0", input2: ",", input3: "=", input4: nil)

        portraitConstraint = numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150)
        landSpaceConstraint = numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        numberStackView.addArrangedSubview(inputStackView1)
        numberStackView.addArrangedSubview(inputStackView2)
        numberStackView.addArrangedSubview(inputStackView3)
        numberStackView.addArrangedSubview(inputStackView4)
        numberStackView.addArrangedSubview(inputStackView5)

        view.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.setContentHuggingPriority(.defaultHigh, for: .vertical) // By setting the hugging high, I prevent the label from expanding and thus the buttons from being squeezed downwards.
        numberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        portraitConstraint.isActive = true

        ///Here you can see how much I have reduced code complexity by making good use of a stackView. At the bottom you can see the code block length when I try to place it without a stackView.
        view.addSubview(numberStackView)
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        numberStackView.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5).isActive = true
        numberStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        numberStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        numberStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

//        view.addSubview(inputStackView1)
//        inputStackView1.translatesAutoresizingMaskIntoConstraints = false
//        inputStackView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        inputStackView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        inputStackView1.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5).isActive = true
//
//        view.addSubview(inputStackView2)
//        inputStackView2.translatesAutoresizingMaskIntoConstraints = false
//        inputStackView2.topAnchor.constraint(equalTo: inputStackView1.bottomAnchor, constant: 1).isActive = true
//        inputStackView2.leadingAnchor.constraint(equalTo: inputStackView1.leadingAnchor).isActive = true
//        inputStackView2.trailingAnchor.constraint(equalTo: inputStackView1.trailingAnchor).isActive = true
//
//        view.addSubview(inputStackView3)
//        inputStackView3.translatesAutoresizingMaskIntoConstraints = false
//        inputStackView3.topAnchor.constraint(equalTo: inputStackView2.bottomAnchor, constant: 1).isActive = true
//        inputStackView3.leadingAnchor.constraint(equalTo: inputStackView2.leadingAnchor).isActive = true
//        inputStackView3.trailingAnchor.constraint(equalTo: inputStackView2.trailingAnchor).isActive = true
//
//
//        view.addSubview(inputStackView4)
//        inputStackView4.translatesAutoresizingMaskIntoConstraints = false
//        inputStackView4.topAnchor.constraint(equalTo: inputStackView3.bottomAnchor, constant: 1).isActive = true
//        inputStackView4.leadingAnchor.constraint(equalTo: inputStackView3.leadingAnchor).isActive = true
//        inputStackView4.trailingAnchor.constraint(equalTo: inputStackView3.trailingAnchor).isActive = true
//
//        view.addSubview(inputStackView5)
//        inputStackView5.translatesAutoresizingMaskIntoConstraints = false
//        inputStackView5.topAnchor.constraint(equalTo: inputStackView4.bottomAnchor, constant: 1).isActive = true
//        inputStackView5.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
//        inputStackView5.leadingAnchor.constraint(equalTo: inputStackView4.leadingAnchor).isActive = true
//        inputStackView5.trailingAnchor.constraint(equalTo: inputStackView4.trailingAnchor).isActive = true
    }
}
