//
//  HomeViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 5/1/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private let headerView = HeaderView()
    
    private let browseLabel = UILabel()
    private var collectionView: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let filterLabel = UILabel()
    private let forYouLabel = UILabel()
    private let logoImageView = UIImageView()
    private var logoutButton = UIButton()
    private let pageLabel = UILabel()
    private let searchBar = UISearchBar()
    private var tableView = UITableView()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let is_authenticated = UserDefaults.standard.bool(forKey: "is_authenticated") // return false if not found or stored value
        if (is_authenticated != true) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.moveToLogin()
        }
        
        setupLogoImage()
        
        
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
    
    // MARK: - Setup Views
    
    private func setupLogoImage() {
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
    }
    
}

extension HomeViewController {
    
    private struct Constants {
        static let itemPadding: CGFloat = 16
        static let linePadding: CGFloat = 16
        static let sectionPadding: CGFloat = 10
        static let filterItemPadding: CGFloat = 1
        static let filterLinePadding: CGFloat = 16
        static let filterSectionPadding: CGFloat = 1
        static let cellWidth: CGFloat = 318
        static let cellHeight: CGFloat = 222
        static let cellSpacing: CGFloat = 8.0
        static let filterCellWidth: CGFloat = 69
        static let filterCellHeight: CGFloat = 24
    }
}
