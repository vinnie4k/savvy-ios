//
//  ViewController.swift
//  Savvy
//
//  Created by Vin Bui on 4/27/23.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    let logoImageView = UIImageView()
    let greetingLabel = UILabel()
    let nameButton = UIButton()
    var logoutButton = UIButton()
    let forYouLabel = UILabel()
    var collectionView: UICollectionView!
    
    let browseLabel = UILabel()
    let searchBar = UISearchBar()
    let filterLabel = UILabel()
    var filterCollectionView: UICollectionView!
    var tableView = UITableView()
    
    // Set up constants
    let itemPadding: CGFloat = 16
    let linePadding: CGFloat = 16
    let sectionPadding: CGFloat = 10
    
    let filterItemPadding: CGFloat = 5
    let filterLinePadding: CGFloat = 16
    let filterSectionPadding: CGFloat = 1
    
    let cellWidth: CGFloat = 323
    let cellHeight: CGFloat = 150
    let cellSpacing: CGFloat = 8.0
    
    let filterCellWidth: CGFloat = 69
    let filterCellHeight: CGFloat = 24
    
    // Set up resue ID's
    let forYouReuseID = "forYouReuseID"
    let filterReuseID = "filterReuseID"
    let reuseID = "postCell"
    
    // Set up data sources
    private var forYouPosts: [Post] = []
    private var allPosts: [Post] = posts
    
    var selectedFilters = [String]()
    var searchFilters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let is_authenticated = UserDefaults.standard.bool(forKey: "is_authenticated") // return false if not found or stored value
        if (is_authenticated != true) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.moveToLogin()
        }
       
        logoImageView.image = UIImage(named: UserDefaults.standard.string(forKey: "netid")!)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 9
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        
        greetingLabel.text = "Good Morning!"
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.font = .systemFont(ofSize: 16, weight: .medium)
        self.view.addSubview(greetingLabel)
        
        nameButton.setTitle(UserDefaults.standard.string(forKey: "userName")!, for: .normal)
        nameButton.setTitleColor(.black, for: .normal)
        nameButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 32)
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        nameButton.addTarget(self, action: #selector(viewProfile), for: .touchUpInside)
        self.view.addSubview(nameButton)
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.layer.backgroundColor = UIColor.white.cgColor
        logoutButton.layer.cornerRadius = 9
        logoutButton.layer.borderWidth = 2
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        
        forYouLabel.text = "For you"
        forYouLabel.translatesAutoresizingMaskIntoConstraints = false
        forYouLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(forYouLabel)
        
        // Set up flow layouts for CollectionViews
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = linePadding
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.tag = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: forYouReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let filterFlowLayout = UICollectionViewFlowLayout()
        filterFlowLayout.minimumInteritemSpacing = filterItemPadding
        filterFlowLayout.minimumLineSpacing = filterLinePadding
        filterFlowLayout.scrollDirection = .horizontal
        filterFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: filterSectionPadding, bottom: 0, right: filterSectionPadding)
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout)
        filterCollectionView.tag = 2
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterCollectionView)
        filterCollectionView.register(SearchFilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseID)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        
        browseLabel.text = "Browse"
        browseLabel.translatesAutoresizingMaskIntoConstraints = false
        browseLabel.font = .systemFont(ofSize: 20, weight: .medium)
        browseLabel.font = UIFont(name: "Times New Roman", size: 24)
        self.view.addSubview(browseLabel)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        
        filterLabel.text = String(allPosts.count) + " Opportunities Available"
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = .systemFont(ofSize: 16, weight: .medium)
        self.view.addSubview(filterLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.rowHeight = cellHeight + cellSpacing
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        filterForYouPosts()
        filterAllPosts()
        setupConstraints()
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            logoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            logoImageView.widthAnchor.constraint(equalToConstant: 64),
            logoImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            nameButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor),
            nameButton.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36)
        ])
        
        NSLayoutConstraint.activate([
            forYouLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            forYouLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            forYouLabel.widthAnchor.constraint(equalToConstant: 86),
            forYouLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: forYouLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            browseLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            browseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            browseLabel.widthAnchor.constraint(equalToConstant: 85),
            browseLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: browseLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            searchBar.widthAnchor.constraint(equalToConstant: 318),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 24),
            filterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            filterLabel.widthAnchor.constraint(equalToConstant: 300),
            filterLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 18),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc func logout() {
        UserDefaults.standard.set(false, forKey: "is_authenticated")
        UserDefaults.standard.set("", forKey: "netid")
        UserDefaults.standard.set("", forKey: "userName")
        let listOfInterests: [String] = []
        UserDefaults.standard.set(listOfInterests, forKey: "interests")
        UserDefaults.standard.synchronize()
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.moveToLogin()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func viewProfile () {
        guard let currentUser = getUser(netid: UserDefaults.standard.string(forKey: "netid")!) else { return }
        let vc = ProfileViewController(user: currentUser)
        //vc.del = self
        navigationController?.pushViewController(vc, animated: true)    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFilters.append(searchBar.text ?? "")
        searchBar.text = ""
        filterAllPosts()
        tableView.reloadData()
        filterCollectionView.reloadData()
        
    }
    
    private func getUser(netid: String) -> User? {
        for user in users {
                if user.netid == netid {
                    return user
                }
            }
            return nil
    }
    /*
    func searchPosts(searchText: String) {
        allPosts.removeAll()
        if (searchText == "") {
            allPosts = posts
        }
        else {
            for curPost in posts {
                if (curPost.type.contains(searchText)
                    || curPost.positionName.contains(searchText)
                    || curPost.description.contains(searchText)
                    || curPost.employer.contains(searchText)
                ) {
                    allPosts.append(curPost)
                    print(curPost.positionName)
                    break
                }
            }
        }
        tableView.reloadData()
        filterCollectionView.reloadData()
    }*/
    
    func filterForYouPosts() {
        guard let currentUser = getUser(netid: UserDefaults.standard.string(forKey: "netid")!) else { return }
        forYouPosts.removeAll()
        if (currentUser.savedTags.count == 0) {
            forYouPosts = []
        }
        else {
            //concatenate tags in user profile
            var combinedTags = ""
            for curTag in currentUser.savedTags {
                combinedTags = combinedTags + " | " + curTag.label
            }
            for curPost in posts {
                for tag in curPost.tags {
                    if (combinedTags.contains(tag.label)) {
                        forYouPosts.append(curPost)
                        break
                    }
                }
            }
        }
        collectionView.reloadData()
    }
    
    func filterAllPosts() {
        allPosts.removeAll()
        if (searchFilters.count == 0) {
            allPosts = posts
        }
        else {
            for curPost in posts {
                for searchText in searchFilters {
                    if (curPost.organization.contains(searchText)
                        || curPost.position.contains(searchText)
                        || curPost.description.contains(searchText)
                        || curPost.qualifications.contains(searchText)
                    ) {
                        allPosts.append(curPost)
                        break
                    }
                }
            }
        }
        filterLabel.text = String(allPosts.count) + " Opportunities Available"
        tableView.reloadData()
        filterCollectionView.reloadData()
    }
    
}
//=====================Collection View 1===========================//
// TODO 6: Conform to UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return forYouPosts.count
        }
        return searchFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forYouReuseID, for: indexPath) as? CustomCollectionViewCell {
                let post = forYouPosts[indexPath.item]
                cell.update(post: post)
                return cell
            }
            return UICollectionViewCell()
        }
        else {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseID, for: indexPath) as? SearchFilterCollectionViewCell {
                let filter = searchFilters[indexPath.item]
                cell.setup(filterLabel: filter)
                return cell
            }
            return UICollectionViewCell()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView.tag == 1) {
            return forYouPosts.count
        }
        return 1
    }
}
// TODO 7: Conform to UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.tag == 1) {
            
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let label = UILabel()
            label.text = searchFilters[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.bounds.width + 40, height: label.bounds.height + 10)
            //return CGSize(width: filterCellWidth, height: filterCellHeight)
        }
       
    }
    
}
// TODO 8: Conform to UICollectionViewDelegate, implement interaction
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 2) {
            
            let item = searchFilters[indexPath.item]
           
            if let index = searchFilters.firstIndex(of: item){
                searchFilters.remove(at: index)
                print(searchFilters)
            }
            /*
            if (isSelected) {
                print("deselect")
                item.isSelected = false
                if let index = selectedFilters.firstIndex(of: filterLabel){
                    selectedFilters.remove(at: index)
                    print(selectedFilters)
                }
            }
            else {
                print("select")
                item.isSelected = true
                selectedFilters.insert(filterLabel, at: 0)
                print(selectedFilters)
            }*/
            filterAllPosts()
        } else {
            let currentPost = forYouPosts[indexPath.item]
            let vc = ViewPostDetailsViewController(post: currentPost)
            //vc.del = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
//=====================Table View==================================//
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? TableViewCell{
            let currentPost = allPosts[indexPath.item]
            cell.updateFrom(post: currentPost)
            return cell
          }
          else {
              return UITableViewCell()
          }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let currentPost = allPosts[indexPath.item]
        let vc = ViewPostDetailsViewController(post: currentPost)
        //vc.del = self
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

