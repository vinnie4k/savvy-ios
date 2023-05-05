//
//  ProfileViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 5/5/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let nameLabel = UILabel()
    let netidLabel = UILabel()
    let classYearLabel = UILabel()
    let editProfileButton = UIButton()
    let lookingLabel = UILabel()
    let editTagButton = UIButton()
    let bookmarksLabel = UILabel()
    let jobsAppliedLabel = UILabel()
    
    var firstCollectionView: UICollectionView!
    var secondCollectionView: UICollectionView!
    var thirdCollectionView: UICollectionView!
    
    // Set up resue ID's
    let firstReuseID = "firstReuseID"
    let secondReuseID = "secondReuseID"
    let thirdReuseID = "thirdResueID"
    
    // Set up constants
    let itemPadding: CGFloat = 16
    let linePadding: CGFloat = 16
    let sectionPadding: CGFloat = 10
    
    let filterItemPadding: CGFloat = 10
    let filterLinePadding: CGFloat = 10
    
    let cellWidth: CGFloat = 323
    let cellHeight: CGFloat = 150
 
    //weak var del: updateCell?
    var user: User
    init(user: User) {
        self.user = user
        self.user.savedPosts = currentPosts
        self.user.appliedPosts = appliedPosts
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: Notification.Name("RefreshPreviousViewController"), object: nil)

        // Do any additional setup after loading the view.
        
        logoImageView.image = UIImage(named: self.user.netid)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 15
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        
        nameLabel.text = self.user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "Times New Roman", size: 32)
        self.view.addSubview(nameLabel)
        
        netidLabel.text = self.user.netid
        netidLabel.translatesAutoresizingMaskIntoConstraints = false
        netidLabel.font = UIFont(name: "SF Pro", size: 16)
        self.view.addSubview(netidLabel)
        
        classYearLabel.text = self.user.classYear
        classYearLabel.translatesAutoresizingMaskIntoConstraints = false
        classYearLabel.font = UIFont(name: "SF Pro", size: 16)
        self.view.addSubview(classYearLabel)
        
        editProfileButton.setImage(UIImage(named: "pencil"), for: .normal)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        self.view.addSubview(editProfileButton)
        
        lookingLabel.text = "I am looking for..."
        lookingLabel.translatesAutoresizingMaskIntoConstraints = false
        lookingLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(lookingLabel)
        
        editTagButton.setImage(UIImage(named: "pencil"), for: .normal)
        editTagButton.translatesAutoresizingMaskIntoConstraints = false
        editTagButton.addTarget(self, action: #selector(editTag), for: .touchUpInside)
        self.view.addSubview(editTagButton)
        
        bookmarksLabel.text = "Bookmarks"
        bookmarksLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarksLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(bookmarksLabel)
        
        jobsAppliedLabel.text = "Jobs Applied"
        jobsAppliedLabel.translatesAutoresizingMaskIntoConstraints = false
        jobsAppliedLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(jobsAppliedLabel)
        
        
        // First CollectionView
        let firstFlowLayout = UICollectionViewFlowLayout()
        firstFlowLayout.minimumInteritemSpacing = filterItemPadding
        firstFlowLayout.minimumLineSpacing = filterLinePadding
        firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: firstFlowLayout)
        firstCollectionView.frame = view.bounds
        firstCollectionView.tag = 1
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstCollectionView)
        firstCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: firstReuseID)
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        
        // Second CollectionView
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.minimumInteritemSpacing = itemPadding
        secondFlowLayout.minimumLineSpacing = linePadding
        secondFlowLayout.scrollDirection = .horizontal
        secondFlowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        secondFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: secondFlowLayout)
        secondCollectionView.tag = 2
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(secondCollectionView)
        secondCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: secondReuseID)
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        
        // Second CollectionView
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.minimumInteritemSpacing = itemPadding
        thirdFlowLayout.minimumLineSpacing = linePadding
        thirdFlowLayout.scrollDirection = .horizontal
        thirdFlowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        thirdFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: thirdFlowLayout)
        thirdCollectionView.tag = 3
        thirdCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(thirdCollectionView)
        thirdCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: thirdReuseID)
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            logoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            logoImageView.widthAnchor.constraint(equalToConstant: 88),
            logoImageView.heightAnchor.constraint(equalToConstant: 88)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            netidLabel.topAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            netidLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            classYearLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            classYearLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23.3),
            editProfileButton.widthAnchor.constraint(equalToConstant: 20),
            editProfileButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            lookingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            lookingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            firstCollectionView.topAnchor.constraint(equalTo: lookingLabel.bottomAnchor, constant: 20),
            firstCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            firstCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            firstCollectionView.bottomAnchor.constraint(equalTo:bookmarksLabel.topAnchor ,constant: -36),
        ])
        
        NSLayoutConstraint.activate([
            editTagButton.topAnchor.constraint(equalTo: lookingLabel.topAnchor),
            editTagButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23.3),
            editTagButton.widthAnchor.constraint(equalToConstant: 20),
            editTagButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bookmarksLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 420),
            bookmarksLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondCollectionView.topAnchor.constraint(equalTo: bookmarksLabel.bottomAnchor, constant: 16),
            secondCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            secondCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            secondCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            jobsAppliedLabel.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 32),
            jobsAppliedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            thirdCollectionView.topAnchor.constraint(equalTo: jobsAppliedLabel.bottomAnchor, constant: 16),
            thirdCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            thirdCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            thirdCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
    }
    
    @objc func editProfile() {
        
    }
    
    @objc func editTag() {
        let vc = EditTagsViewController(user: user)
        //vc.del = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshView() {
        firstCollectionView.reloadData()
    }

}
//=====================Collection View ===========================//
// TODO 6: Conform to UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return user.savedTags.count
        } else if (collectionView.tag == 2) {
            return user.savedPosts.count
        }
        return user.appliedPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstReuseID, for: indexPath) as? TagCollectionViewCell {
                let tag = user.savedTags[indexPath.item]
                cell.configure(tag: tag)
                return cell
            }
        } else if (collectionView.tag == 2) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondReuseID, for: indexPath) as? CustomCollectionViewCell {
                let post = user.savedPosts[indexPath.item]
                cell.update(post: post)
                return cell
            }
        }
        
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thirdReuseID, for: indexPath) as? CustomCollectionViewCell {
                let post = user.appliedPosts[indexPath.item]
                cell.update(post: post)
                return cell
            }
            
        }
        return UICollectionViewCell()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        if (collectionView.tag == 1) {
            return 1
        } else if (collectionView.tag == 2) {
            return user.savedPosts.count
        } else {
            return user.appliedPosts.count
        }
    }
}
// TODO 7: Conform to UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.tag == 1) {
            let label = UILabel()
            label.text = user.savedTags[indexPath.item].label
            label.sizeToFit()
            return CGSize(width: label.bounds.width, height: label.bounds.height + 5)
        } else if (collectionView.tag == 2) {
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else {
            return CGSize(width: cellWidth, height: cellHeight)
        }
       
    }
   
        /*
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return filterLinePadding
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return filterItemPadding
        }*/
    
}
// TODO 8: Conform to UICollectionViewDelegate, implement interaction
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 1) {

        } else if (collectionView.tag == 2) {
            let currentPost = user.savedPosts[indexPath.item]
            let vc = ViewPostDetailsViewController(post: currentPost)
            //vc.del = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let currentPost = user.appliedPosts[indexPath.item]
            let vc = ViewPostDetailsViewController(post: currentPost)
            //vc.del = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
