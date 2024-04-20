//
//  FeedVC.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit
import Alamofire

class FeedVC: UIViewController {

    // MARK: - Properties (view)

    private var collectionView: UICollectionView!
//    private let refreshControl = UIRefreshControl()

    // MARK: - Properties (data)

    private var recipes: [Recipe] = Recipe.dummyData
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ChefOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        setupCollectionView()
    }
    
//    // MARK: - Networking
//    
//    @objc private func fetchPosts() {
//        NetworkManager.shared.fetchPosts { [weak self] posts in
//            guard let self = self else { return }
//            self.posts = posts
//
//            // Perform UI update on main queue
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                self.refreshControl.endRefreshing()
//            }
//        }
//    }

    // MARK: - Set Up Views
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.collectionView.collectionViewLayout.invalidateLayout()
     }
    private func setupCollectionView() {

        // Set Up CollectionView
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 33
        
        // Initialize CollectionView with the layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        collectionView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        
//        refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
//        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -86),
                ])
    }

}

// MARK: - UICollectionViewDelegate

extension FeedVC: UICollectionViewDelegate { 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let viewController2 = DetailedRecipeVC(recipe: recipe)
        navigationController?.pushViewController(viewController2, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension FeedVC: UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Return the cells for each section
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as? RecipeCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: recipes[indexPath.row])
            return cell
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections in this table view
        return 1
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each cell per section
        return CGSize(width: 148, height: 212)
    }

}
