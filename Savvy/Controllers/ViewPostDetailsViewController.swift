//
//  ViewPostDetailsViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit

class ViewPostDetailsViewController: UIViewController {
    
    let positionLabel = UILabel()
    let organizationLabel = UILabel()
    let createDateLabel = UILabel()
    let paymentTextView = UITextView()
    let paymentLabel = UILabel()
    let applyButton = UIButton()
    let separatorView = UIView()
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
       
    //weak var del: updateCell?
    var post: Post
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
           
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Positon Details"
        view.backgroundColor = .white
    
            
        positionLabel.text = self.post.position
        positionLabel.textColor = .black
        positionLabel.font = .systemFont(ofSize: 32)
        positionLabel.numberOfLines = 1
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(positionLabel)
        
        organizationLabel.text = self.post.organization
        organizationLabel.textColor = .black
        organizationLabel.font = .systemFont(ofSize: 20)
        organizationLabel.numberOfLines = 1
        organizationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(organizationLabel)
        
        createDateLabel.text = "Posted " + self.post.createDate
        createDateLabel.textColor = .black
        createDateLabel.font = .systemFont(ofSize: 16)
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createDateLabel)
        
        paymentTextView.backgroundColor = UIColor(red: CGFloat(242.0/255.0), green: CGFloat(233.0/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        paymentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentTextView)
        
        paymentLabel.text = self.post.payment
        paymentLabel.textColor = .black
        paymentLabel.font = .systemFont(ofSize: 16)
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentLabel)
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.backgroundColor = UIColor.black.cgColor
        applyButton.layer.cornerRadius = 18
        applyButton.clipsToBounds = true
        applyButton.addTarget(self, action: #selector(applyPosition), for: .touchUpInside)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyButton)
        
        separatorView.backgroundColor = UIColor.lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        
        descriptionLabel.text = "Job Description"
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        descriptionTextView.text = self.post.description
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        setupConstraints()
    }
       
    func setupConstraints() {
               
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            positionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            organizationLabel.topAnchor.constraint(equalTo: self.positionLabel.bottomAnchor, constant: 5),
            organizationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            organizationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            createDateLabel.topAnchor.constraint(equalTo: self.organizationLabel.bottomAnchor, constant: 8),
            createDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            createDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            paymentTextView.topAnchor.constraint(equalTo: self.createDateLabel.bottomAnchor, constant: 8),
            paymentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            paymentTextView.widthAnchor.constraint(equalToConstant: 69),
            paymentTextView.heightAnchor.constraint(equalToConstant: 24)
        ])
           
        NSLayoutConstraint.activate([
            paymentLabel.centerXAnchor.constraint(equalTo: self.paymentTextView.centerXAnchor),
            paymentLabel.centerYAnchor.constraint(equalTo: self.paymentTextView.centerYAnchor)
        ])
           
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: paymentTextView.bottomAnchor, constant: 34),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.widthAnchor.constraint(equalToConstant: 318),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 32),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.separatorView.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 151),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
        
    }
    @objc func applyPosition() {
        print("Apply position!")
    }
}

   

