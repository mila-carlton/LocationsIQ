//
//  CategoriesCollectionViewCell.swift
//  LocationIQApp
//
//  Created by PASGON TEXTILE on 22.03.24.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    static let id = "\(CategoriesCollectionViewCell.self)"
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black.withAlphaComponent(0.8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        return imageView
        
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
        contentView.backgroundColor = .white.withAlphaComponent(0.9)
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: Category) {
        locationImageView.image = category.image
        nameLabel.text = category.name
    }
    
    private func autoLayout() {
        
        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 4),
            locationImageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 40),
            locationImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 180),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
