//
//  CustomCollectionViewCell.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    //let imageView = UIImageView()
    
    let positionLabel = UILabel()
    let organizationLabel = UILabel()
    let createDateLabel = UILabel()
    let paymentTextView = UITextView()
    let paymentLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
            
        positionLabel.textColor = .black
        positionLabel.font = .systemFont(ofSize: 24)
        positionLabel.numberOfLines = 1
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(positionLabel)
        
        organizationLabel.textColor = .black
        organizationLabel.font = .systemFont(ofSize: 16)
        organizationLabel.numberOfLines = 1
        organizationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(organizationLabel)
        
        createDateLabel.textColor = .black
        createDateLabel.font = .systemFont(ofSize: 16)
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(createDateLabel)
        
        paymentTextView.backgroundColor = UIColor(red: CGFloat(242.0/255.0), green: CGFloat(233.0/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        paymentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(paymentTextView)
        
        paymentLabel.textColor = .black
        paymentLabel.font = .systemFont(ofSize: 16)
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(paymentLabel)
        
        setUpConstraints()
    }
        
    func setUpConstraints() {
            
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            positionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            organizationLabel.topAnchor.constraint(equalTo: self.positionLabel.bottomAnchor, constant: 5),
            organizationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            organizationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            createDateLabel.topAnchor.constraint(equalTo: self.organizationLabel.bottomAnchor, constant: 8),
            createDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            createDateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            paymentTextView.topAnchor.constraint(equalTo: self.createDateLabel.bottomAnchor, constant: 8),
            paymentTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            paymentTextView.widthAnchor.constraint(equalToConstant: 69),
            paymentTextView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            paymentLabel.centerXAnchor.constraint(equalTo: self.paymentTextView.centerXAnchor),
            paymentLabel.centerYAnchor.constraint(equalTo: self.paymentTextView.centerYAnchor)
        ])
        
    }
        
    func update(post: Post) {
        //imageView.image = UIImage(named: restaurant.imageName)
        positionLabel.text = post.position
        organizationLabel.text = post.organization
        createDateLabel.text = "Posted " + post.createDate
        paymentLabel.text = post.payment
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}

