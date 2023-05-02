//
//  CustomFilterCollectionViewCell.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit
class CustomFilterCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor(red: CGFloat(217.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(217.0/255.0), alpha: CGFloat(1.0))
        label.textAlignment = .center
        contentView.addSubview(label)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    
    func configure(filterName: Filter) {
        label.text = filterName.filterLabel
        
        if (filterName.isSelected) {
            label.textColor = .white
            label.backgroundColor = UIColor.black
        } else {
            label.textColor = UIColor.black
            label.backgroundColor = UIColor(red: CGFloat(217.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(217.0/255.0), alpha: CGFloat(1.0))
            
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
