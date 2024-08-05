//
//  Helper.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import UIKit

class Helper {
    
    static func applyCornerRadius(to view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    static func applyShadow(to view: UIView, color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity
        view.layer.masksToBounds = false
    }
}


class FoodItemsHeaderView: UIView {
    
    private let stackView = UIStackView()
    
    var titleCatagory: [String] = [] {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupButtons() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in titleCatagory {
            let button = UIButton(type: .system)
            button.setTitle(item, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor.systemGray6
            button.tintColor = UIColor.orange
            button.setTitleColor(.orange, for: .selected)
            stackView.addArrangedSubview(button)
        }
    }
}
