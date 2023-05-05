//
//  SearchFilterCollectionViewCell.swift
//  Savvy
//
//  Created by Jenny Yu on 5/5/23.
//

import UIKit

class SearchFilterCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor(red: CGFloat(217.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(217.0/255.0), alpha: CGFloat(1.0))
        label.textAlignment = .center
        contentView.addSubview(label)
        
        deleteButton.setImage(UIImage(named: "delete"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteFilter), for: .touchUpInside)
        contentView.addSubview(deleteButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 10),
            deleteButton.heightAnchor.constraint(equalToConstant: 10)
            
        ])
    }
    
    func setup(filterLabel: String) {
        label.text = filterLabel
    }
    
    @objc func deleteFilter(sender: UIButton) {
        /*
        if let collectionView = superview as? UICollectionView,
                   let indexPath = collectionView.indexPath(for: self) {
                    collectionView.deleteItems(at: [indexPath])
                }*/
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
