//
//  TableViewCell.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit
class TableViewCell: UITableViewCell {
    let cellView = UIView()
    let typeLabel = UILabel()
    let positionNameLabel = UILabel()
    let employerLabel = UILabel()
    let durationLabel = UILabel()
    let wageTextView = UITextView()
    let wageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        cellView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        cellView.layer.cornerRadius = 10
        cellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellView)
        
        typeLabel.textColor = .black
        typeLabel.font = .systemFont(ofSize: 16)
        typeLabel.numberOfLines = 1
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(typeLabel)
            
        positionNameLabel.textColor = .black
        positionNameLabel.font = .systemFont(ofSize: 32)
        positionNameLabel.numberOfLines = 1
        positionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(positionNameLabel)
        
        employerLabel.textColor = .black
        employerLabel.font = .systemFont(ofSize: 20)
        employerLabel.numberOfLines = 1
        employerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(employerLabel)
        
        durationLabel.textColor = .black
        durationLabel.font = .systemFont(ofSize: 16)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(durationLabel)
        
        wageTextView.backgroundColor = UIColor.white
        wageTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wageTextView)
        
        wageLabel.textColor = .black
        wageLabel.font = .systemFont(ofSize: 16)
        wageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wageLabel)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            cellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellView.heightAnchor.constraint(equalToConstant:318),
            cellView.widthAnchor.constraint(equalToConstant: 222),
            cellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            typeLabel.heightAnchor.constraint(equalToConstant:19)
        ])
            
        NSLayoutConstraint.activate([
            positionNameLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 32),
            positionNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            positionNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            employerLabel.topAnchor.constraint(equalTo: self.positionNameLabel.bottomAnchor, constant: 5),
            employerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            employerLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: self.employerLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            durationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            wageTextView.topAnchor.constraint(equalTo: self.durationLabel.bottomAnchor, constant: 8),
            wageTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            wageTextView.widthAnchor.constraint(equalToConstant: 69),
            wageTextView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            wageLabel.centerXAnchor.constraint(equalTo: self.wageTextView.centerXAnchor),
            wageLabel.centerYAnchor.constraint(equalTo: self.wageTextView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateFrom (post: Post) {
        //imageView.image = UIImage(named: restaurant.imageName)
        typeLabel.text = post.type
        positionNameLabel.text = post.positionName
        employerLabel.text = post.employer
        durationLabel.text = post.duration
        wageLabel.text = "$" + post.wage
    }
    
    
}
