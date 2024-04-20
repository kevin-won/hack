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

    private var collectionViewOne: UICollectionView!
    private var collectionViewTwo: UICollectionView!

    // MARK: - Properties (data)

    private var filters = [Filter(type: "All", selected: true), Filter(type: "Beginner", selected: false), Filter(type: "Intermediate", selected: false), Filter(type: "Advanced", selected: false)]
    private var allRecipes: [Recipe] = []
    private var recipes: [Recipe] = []
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ChefOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        setupCollectionView()
    }
    
    // MARK: - Networking
    
    @objc private func fetchRecipes() {
        NetworkManager.shared.fetchRecipes { [weak self] recipes in
            guard let self = self else { return }
            self.allRecipes = recipes
            self.recipes = recipes

            // Perform UI update on main queue
            DispatchQueue.main.async {
                self.collectionViewTwo.reloadData()
            }
        }
    }

    // MARK: - Set Up Views

    private func setupCollectionView() {
        // Set Up CollectionView
        let layoutOne = UICollectionViewFlowLayout()
        layoutOne.scrollDirection = .horizontal
        layoutOne.minimumInteritemSpacing = 12
        
        collectionViewOne = UICollectionView(frame: .zero, collectionViewLayout: layoutOne)
        collectionViewOne.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuse)
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        
        view.addSubview(collectionViewOne)
        collectionViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            collectionViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionViewOne.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
        let layoutTwo = UICollectionViewFlowLayout()
        layoutTwo.scrollDirection = .vertical
        layoutTwo.minimumLineSpacing = 24
        layoutTwo.minimumInteritemSpacing = 33
        
        // Initialize CollectionView with the layout
        collectionViewTwo = UICollectionView(frame: .zero, collectionViewLayout: layoutTwo)
        collectionViewTwo.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.alwaysBounceVertical = true
        
        collectionViewTwo.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        view.addSubview(collectionViewTwo)
        collectionViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            collectionViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            collectionViewTwo.topAnchor.constraint(equalTo: collectionViewOne.bottomAnchor, constant: 32),
            collectionViewTwo.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        fetchRecipes()
    }

}

// MARK: - UICollectionViewDelegate

extension FeedVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewOne {
            self.filters = filters.map { Filter(type: $0.type, selected: false) }
            self.filters[indexPath.row].selected = true
            
            collectionViewOne.reloadData()
            
            filterRecipes()
        } else {
            let recipe = recipes[indexPath.row]
            let viewController2 = DetailedRecipeVC(recipe: recipe)
            navigationController?.pushViewController(viewController2, animated: true)
        }
    }
    
    private func filterRecipes() {
        if let selectedFilter = filters.first(where: { $0.selected }) {
            if selectedFilter.type == "All" {
                self.recipes = self.allRecipes
            } else {
                self.recipes = self.allRecipes.filter { $0.difficulty == selectedFilter.type }
            }
        }
        collectionViewTwo.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension FeedVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Return the cells for each section
        if collectionView == collectionViewOne {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuse, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(filter: filters[indexPath.row])
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as? RecipeCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(recipe: recipes[indexPath.row])
                return cell
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return 4
        } else {
            return recipes.count
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each cell per section
        if collectionView == collectionViewOne {
            return CGSize(width: 116, height: 32)
        } else {
            return CGSize(width: 148, height: 212)
        }
    }

}
