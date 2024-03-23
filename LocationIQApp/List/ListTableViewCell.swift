//
//  ListTableViewCell.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 23.03.24.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    
    static let id = "\(ListTableViewCell.self)"
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    func configure(listItem: CategoriesModelElement) {
        titleLabel.text = listItem.name?.capitalized ?? ""
    }
    
    
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        baseView.layer.masksToBounds = true
        baseView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            
            titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -12),
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

