//
//  ViewController.swift
//  Savvy
//
//  Created by Vin Bui on 4/27/23.
//

import UIKit
class ViewController: UIViewController, UISearchBarDelegate {
    let logoImageView = UIImageView()
    let pageLabel = UILabel()
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
    
    let filterItemPadding: CGFloat = 1
    let filterLinePadding: CGFloat = 16
    let filterSectionPadding: CGFloat = 1
    
    let cellWidth: CGFloat = 318
    let cellHeight: CGFloat = 222
    let cellSpacing: CGFloat = 8.0
    
    let filterCellWidth: CGFloat = 69
    let filterCellHeight: CGFloat = 24
    
    // Set up resue ID's
    let forYouReuseID = "forYouReuseID"
    let filterReuseID = "filterReuseID"
    let reuseID = "postCell"
    
    // Set up data sources
    private var forYouPosts: [[Post]] = [[]]
    var forYouFilters:[String] = UserDefaults.standard.array(forKey: "interests") as? [String] ?? []
    
    private var allPosts: [[Post]] = [posts]
    var selectedFilters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let is_authenticated = UserDefaults.standard.bool(forKey: "is_authenticated") // return false if not found or stored value
        if (is_authenticated != true) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.moveToLogin()
        }
        
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        
        pageLabel.text = "Hey, " + (UserDefaults.standard.string(forKey: "userName") ?? "")
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        pageLabel.font = .systemFont(ofSize: 24, weight: .medium)
        self.view.addSubview(pageLabel)
        
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
        forYouLabel.font = .systemFont(ofSize: 20, weight: .medium)
        self.view.addSubview(forYouLabel)
        
        // Set up flow layouts for CollectionViews
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = linePadding
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        flowLayout.itemSize = CGSize(width: 318, height: 222)
        // Instantiate CollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.tag = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        let filterFlowLayout = UICollectionViewFlowLayout()
        filterFlowLayout.minimumInteritemSpacing = filterItemPadding
        filterFlowLayout.minimumLineSpacing = filterLinePadding
        filterFlowLayout.scrollDirection = .horizontal
        filterFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: filterSectionPadding, bottom: 0, right: filterSectionPadding)
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout)
        filterCollectionView.tag = 2
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterCollectionView)
        
        
        // Create CollectionViewCell and register it here
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: forYouReuseID)
        filterCollectionView.register(CustomFilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseID)
        
        // Set CollectionView data source
        collectionView.dataSource = self
        filterCollectionView.dataSource = self
        
        // Set CollectionView delegate
        collectionView.delegate = self
        filterCollectionView.delegate = self
        
        browseLabel.text = "Browse"
        browseLabel.translatesAutoresizingMaskIntoConstraints = false
        browseLabel.font = .systemFont(ofSize: 20, weight: .medium)
        self.view.addSubview(browseLabel)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        
        filterLabel.text = "Filter by:"
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
    
    func filterForYouPosts() {
        forYouPosts[0].removeAll()
        if (forYouFilters.count == 0) {
            forYouPosts[0] = []
        }
        else {
            for curPost in posts {
                for curFilter in forYouFilters {
                    if (curPost.type.contains(curFilter)) {
                        forYouPosts[0].append(curPost)
                        print(curPost.positionName)
                        break
                    }
                }
            }
        }
        collectionView.reloadData()
    }
    
    func filterAllPosts() {
        allPosts[0].removeAll()
        if (selectedFilters.count == 0) {
            allPosts[0] = posts
        }
        else {
            for curPost in posts {
                for curFilter in selectedFilters {
                    if (curPost.type.contains(curFilter)) {
                        allPosts[0].append(curPost)
                        print(curPost.positionName)
                        break
                    }
                }
            }
        }
        tableView.reloadData()
        filterCollectionView.reloadData()
    }
    
    func searchPosts(searchText: String) {
        allPosts[0].removeAll()
        if (searchText == "") {
            allPosts[0] = posts
        }
        else {
            for curPost in posts {
                if (curPost.type.contains(searchText)
                    || curPost.positionName.contains(searchText)
                    || curPost.description.contains(searchText)
                    || curPost.employer.contains(searchText)
                ) {
                    allPosts[0].append(curPost)
                    print(curPost.positionName)
                    break
                }
            }
        }
        tableView.reloadData()
        filterCollectionView.reloadData()
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            logoImageView.widthAnchor.constraint(equalToConstant: 36),
            logoImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            pageLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            pageLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36)
        ])
        
        NSLayoutConstraint.activate([
            forYouLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            forYouLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            forYouLabel.widthAnchor.constraint(equalToConstant: 71),
            forYouLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: forYouLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 222)
        ])
        
        NSLayoutConstraint.activate([
            browseLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            browseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            browseLabel.widthAnchor.constraint(equalToConstant: 72),
            browseLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: browseLabel.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            searchBar.widthAnchor.constraint(equalToConstant: 318),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 28),
            filterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            filterLabel.widthAnchor.constraint(equalToConstant: 67),
            filterLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: filterLabel.trailingAnchor, constant: 5),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 26)
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
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search")
        searchPosts(searchText: searchText)
    }
    
}
//=====================Collection View 1===========================//
// TODO 6: Conform to UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return forYouPosts[section].count
        }
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forYouReuseID, for: indexPath) as? CustomCollectionViewCell {
                let post = forYouPosts[indexPath.section][indexPath.item]
                cell.update(post: post)
                return cell
            }
            return UICollectionViewCell()
        }
        else {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseID, for: indexPath) as? CustomFilterCollectionViewCell {
                let filter = filters[indexPath.item]
                cell.configure(filterName: filter)
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
            return CGSize(width: filterCellWidth, height: filterCellHeight)
            
        }
    }
    
}
// TODO 8: Conform to UICollectionViewDelegate, implement interaction
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 2) {
            let item = filters[indexPath.item]
            let isSelected = item.isSelected
            let filterLabel = item.filterLabel
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
            }
            filterAllPosts()
        } else {
            let currentPost = forYouPosts[indexPath.section][indexPath.item]
            let vc = ViewPostDetailsViewController(post: currentPost)
            //vc.del = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
//=====================Table View==================================//
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts[0].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? TableViewCell{
            let currentPost = allPosts[indexPath.section][indexPath.item]
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
        let currentPost = allPosts[indexPath.section][indexPath.item]
        let vc = ViewPostDetailsViewController(post: currentPost)
        //vc.del = self
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

