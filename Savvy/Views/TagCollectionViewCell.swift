//
//  TagCollectionViewCell.swift
//  Savvy
//
//  Created by Jenny Yu on 5/5/23.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
        let label = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.font = UIFont(name: "Helvetica", size: 16)
            contentView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            setupConstraints()
        }
    
        func setupConstraints() {
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                label.topAnchor.constraint(equalTo: contentView.topAnchor),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            ])
        }

    func configure(tag: Tag) {
        label.text = tag.label
        
        if (tag.type == "Field") {
            label.backgroundColor = UIColor(red: CGFloat(242.0/255.0), green: CGFloat(233.0/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        }
        else if (tag.type == "Location") {
            label.backgroundColor = UIColor(red: CGFloat(233.0/255.0), green: CGFloat(245.0/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        }
        else if (tag.type == "Payment") {
            label.backgroundColor = UIColor(red: CGFloat(238.0/255.0), green: CGFloat(247.0/255.0), blue: CGFloat(233/255.0), alpha: 1.0)
        }
        else if (tag.type == "Qualifications") {
            label.backgroundColor = UIColor(red: CGFloat(247.0/255.0), green: CGFloat(235.0/255.0), blue: CGFloat(233/255.0), alpha: 1.0)
        }
        else {
                label.textColor = UIColor.black
                label.backgroundColor = UIColor.white
            
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
