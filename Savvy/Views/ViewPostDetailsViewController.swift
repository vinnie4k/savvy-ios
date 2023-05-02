//
//  ViewPostDetailsViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit

class ViewPostDetailsViewController: UIViewController {
    
    let typeLabel = UILabel()
    let positionNameLabel = UILabel()
    let employerLabel = UILabel()
    let durationLabel = UILabel()
    let wageTextView = UITextView()
    let wageLabel = UILabel()
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
        
        print(self.post.type)
        
        // Do any additional setup after loading the view.
        typeLabel.text = self.post.type
        typeLabel.textColor = .black
        typeLabel.font = .systemFont(ofSize: 16)
        typeLabel.numberOfLines = 1
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(typeLabel)
            
        positionNameLabel.text = self.post.positionName
        positionNameLabel.textColor = .black
        positionNameLabel.font = .systemFont(ofSize: 32)
        positionNameLabel.numberOfLines = 1
        positionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(positionNameLabel)
        
        employerLabel.text = self.post.employer
        employerLabel.textColor = .black
        employerLabel.font = .systemFont(ofSize: 20)
        employerLabel.numberOfLines = 1
        employerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(employerLabel)
        
        durationLabel.text = self.post.duration
        durationLabel.textColor = .black
        durationLabel.font = .systemFont(ofSize: 16)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durationLabel)
        
        wageTextView.backgroundColor = UIColor.lightGray
        wageTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wageTextView)
        
        wageLabel.text = "$" + self.post.wage
        wageLabel.textColor = .black
        wageLabel.font = .systemFont(ofSize: 16)
        wageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wageLabel)
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.backgroundColor = UIColor.black.cgColor
        applyButton.layer.cornerRadius = 10
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
            typeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            typeLabel.heightAnchor.constraint(equalToConstant:19)
        ])
               
        NSLayoutConstraint.activate([
            positionNameLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 32),
            positionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            positionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            employerLabel.topAnchor.constraint(equalTo: self.positionNameLabel.bottomAnchor, constant: 5),
            employerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            employerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: self.employerLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            durationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
           
        NSLayoutConstraint.activate([
            wageTextView.topAnchor.constraint(equalTo: self.durationLabel.bottomAnchor, constant: 8),
            wageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            wageTextView.widthAnchor.constraint(equalToConstant: 69),
            wageTextView.heightAnchor.constraint(equalToConstant: 24)
        ])
           
        NSLayoutConstraint.activate([
            wageLabel.centerXAnchor.constraint(equalTo: self.wageTextView.centerXAnchor),
            wageLabel.centerYAnchor.constraint(equalTo: self.wageTextView.centerYAnchor)
        ])
           
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: wageTextView.bottomAnchor, constant: 34),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.widthAnchor.constraint(equalToConstant: 318),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 42),
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

   

