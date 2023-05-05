//
//  EditTagsViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 5/5/23.
//

import UIKit

class EditTagsViewController: UIViewController {
    
    let lookingLabel = UILabel()
    let fieldLabel = UILabel()
    let locationLabel = UILabel()
    let paymentLabel = UILabel()
    let qualificationsLabel = UILabel()
    
    var lookingForCollectionView: UICollectionView!
    var fieldCollectionView: UICollectionView!
    var locationCollectionView: UICollectionView!
    var paymentCollectionView: UICollectionView!
    var qualificationsCollectionView: UICollectionView!
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // Set up resue ID's
    let lookingForReuseID = "lookingForReuseID"
    let headerReuseID = "headerReuseID"
    let fieldReuseID = "fieldReuseID"
    let locationReuseID = "locationResueID"
    let paymentReuseID = "paymentResueID"
    let qualificationsReuseID = "qualificationsResueID"

    // Set up constants
    let filterItemPadding: CGFloat = 10
    let filterLinePadding: CGFloat = 10

    //weak var del: updateCell?
    var user: User
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Tags"
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        lookingLabel.text = "I am looking for..."
        lookingLabel.translatesAutoresizingMaskIntoConstraints = false
        lookingLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(lookingLabel)
        
        fieldLabel.text = "Field"
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        fieldLabel.font = UIFont(name: "Times New Roman", size: 18)
        self.view.addSubview(fieldLabel)
        
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont(name: "Times New Roman", size: 18)
        self.view.addSubview(locationLabel)
        
        paymentLabel.text = "Payment"
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentLabel.font = UIFont(name: "Times New Roman", size: 18)
        self.view.addSubview(paymentLabel)
        
        qualificationsLabel.text = "Qualifications"
        qualificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        qualificationsLabel.font = UIFont(name: "Times New Roman", size: 18)
        self.view.addSubview(qualificationsLabel)
        
        // First CollectionView
        let lookingForFlowLayout = UICollectionViewFlowLayout()
        lookingForFlowLayout.minimumInteritemSpacing = filterItemPadding
        lookingForFlowLayout.minimumLineSpacing = filterLinePadding
        lookingForCollectionView = UICollectionView(frame: .zero, collectionViewLayout: lookingForFlowLayout)
        lookingForCollectionView.frame = view.bounds
        lookingForCollectionView.tag = 1
        lookingForCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lookingForCollectionView)
        lookingForCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: lookingForReuseID)
        lookingForCollectionView.dataSource = self
        lookingForCollectionView.delegate = self
        
        // Second CollectionView
        let fieldFlowLayout = UICollectionViewFlowLayout()
        fieldFlowLayout.minimumInteritemSpacing = filterItemPadding
        fieldFlowLayout.minimumLineSpacing = filterLinePadding
        fieldCollectionView = UICollectionView(frame: .zero, collectionViewLayout: fieldFlowLayout)
        fieldCollectionView.tag = 2
        fieldCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fieldCollectionView)
        fieldCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: fieldReuseID)
        fieldCollectionView.dataSource = self
        fieldCollectionView.delegate = self
        
        // Third CollectionView
        let locationFlowLayout = UICollectionViewFlowLayout()
        locationFlowLayout.minimumInteritemSpacing = filterItemPadding
        locationFlowLayout.minimumLineSpacing = filterLinePadding
        locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: locationFlowLayout)
        locationCollectionView.tag = 3
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationCollectionView)
        locationCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: locationReuseID)
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        
        // Fourth CollectionView
        let paymentFlowLayout = UICollectionViewFlowLayout()
        paymentFlowLayout.minimumInteritemSpacing = filterItemPadding
        paymentFlowLayout.minimumLineSpacing = filterLinePadding
        paymentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: paymentFlowLayout)
        paymentCollectionView.frame = view.bounds
        paymentCollectionView.tag = 4
        paymentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentCollectionView)
        paymentCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: paymentReuseID)
        paymentCollectionView.dataSource = self
        paymentCollectionView.delegate = self
        
        // Fifth CollectionView
        let qualificationsFlowLayout = UICollectionViewFlowLayout()
        qualificationsFlowLayout.minimumInteritemSpacing = filterItemPadding
        qualificationsFlowLayout.minimumLineSpacing = filterLinePadding
        qualificationsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: qualificationsFlowLayout)
        qualificationsCollectionView.tag = 5
        qualificationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qualificationsCollectionView)
        qualificationsCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: qualificationsReuseID)
        qualificationsCollectionView.dataSource = self
        qualificationsCollectionView.delegate = self
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            lookingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            lookingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            lookingForCollectionView.topAnchor.constraint(equalTo: lookingLabel.bottomAnchor, constant: 20),
            lookingForCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lookingForCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lookingForCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
       
        NSLayoutConstraint.activate([
            fieldLabel.topAnchor.constraint(equalTo: lookingForCollectionView.bottomAnchor, constant: 36),
            fieldLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            fieldCollectionView.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor, constant: 20),
            fieldCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fieldCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            fieldCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: fieldCollectionView.bottomAnchor, constant: 36),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            locationCollectionView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            paymentLabel.topAnchor.constraint(equalTo: locationCollectionView.bottomAnchor, constant: 36),
            paymentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            paymentCollectionView.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 20),
            paymentCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            paymentCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            paymentCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            qualificationsLabel.topAnchor.constraint(equalTo: paymentCollectionView.bottomAnchor, constant: 36),
            qualificationsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            qualificationsCollectionView.topAnchor.constraint(equalTo: qualificationsLabel.bottomAnchor, constant: 20),
            qualificationsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            qualificationsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            qualificationsCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

//=====================Collection View ===========================//
// TODO 6: Conform to UICollectionViewDataSource
extension EditTagsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return user.savedTags.count
        } else if (collectionView.tag == 2) {
            return fieldsTags.count
        } else if (collectionView.tag == 3) {
            return locationTags.count
        } else if (collectionView.tag == 4) {
            return paymentTags.count
        } else if (collectionView.tag == 5) {
            return qualificationsTags.count
        } else {
            return user.savedTags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lookingForReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = user.savedTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else if (collectionView.tag == 2) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fieldReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = fieldsTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else if (collectionView.tag == 3) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = locationTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else if (collectionView.tag == 4) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: paymentReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = paymentTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else if (collectionView.tag == 5) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: qualificationsReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = qualificationsTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else {
        }
        return UICollectionViewCell()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// TODO 7: Conform to UICollectionViewDelegateFlowLayout
extension EditTagsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        if (collectionView.tag == 1) {
            label.text = user.savedTags[indexPath.item].label
        } else if (collectionView.tag == 2) {
            label.text = fieldsTags[indexPath.item].label
        } else if (collectionView.tag == 3) {
            label.text = locationTags[indexPath.item].label
        } else if (collectionView.tag == 4) {
            label.text = paymentTags[indexPath.item].label
        } else if (collectionView.tag == 5) {
            label.text = qualificationsTags[indexPath.item].label
        } else {
            return CGSize(width: 10, height: 10)
        }
        label.sizeToFit()
        print (label.bounds.height)
        return CGSize(width: label.bounds.width, height: label.bounds.height + 10)
    }
    
}
// TODO 8: Conform to UICollectionViewDelegate, implement interaction
extension EditTagsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 1) {
            
        } else if (collectionView.tag == 2){
            let item = fieldsTags[indexPath.item]
            user.savedTags.append(item)
            lookingForCollectionView.reloadData()
        } else if (collectionView.tag == 3){
            let item = locationTags[indexPath.item]
            user.savedTags.append(item)
            lookingForCollectionView.reloadData()
        } else if (collectionView.tag == 4){
            let item = paymentTags[indexPath.item]
            user.savedTags.append(item)
            lookingForCollectionView.reloadData()
        } else if (collectionView.tag == 5){
            let item = qualificationsTags[indexPath.item]
            user.savedTags.append(item)
            lookingForCollectionView.reloadData()
        } else {
            
        }
        NotificationCenter.default.post(name: Notification.Name("RefreshPreviousViewController"), object: nil)
    }
}

