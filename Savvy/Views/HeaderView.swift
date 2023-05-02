//
//  HeaderView.swift
//  Savvy
//
//  Created by Jenny Yu on 5/1/23.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties (view)
    
    private let goodMorningLabel = UILabel()
    private let nameLabel = UILabel()
    private let profileImage = UIImageView()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabels()
        setupProfileImage()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setupLabels() {
        goodMorningLabel.font = .sfPro(size: 16, weight: .medium)
        goodMorningLabel.text = "Good morning!"
        goodMorningLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(goodMorningLabel)
    }
    
    private func setupProfileImage() {
        profileImage.image = .init(systemName: "person")
        profileImage.layer.cornerRadius = 8
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goodMorningLabel.topAnchor.constraint(equalTo: topAnchor),
            goodMorningLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding)
        ])
    }
    
}
