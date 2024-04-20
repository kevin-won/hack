//
//  DetailedRecipeVC.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit

class DetailedRecipeVC: UIViewController {
    
    // MARK: - Properties (view)
    private let recipeImage = UIImageView()
    private let recipeLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupRecipeImage()
        setupRecipeLabel()
        setupDescriptionLabel()
    }
    
    init(recipe: Recipe) {
        recipeImage.sd_setImage(with: URL(string: recipe.imageUrl))
        recipeLabel.text = recipe.name
        descriptionLabel.text = recipe.description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    
    private func setupRecipeImage() {
        recipeImage.layer.cornerRadius = 10
        recipeImage.layer.masksToBounds = true
        
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        
        view.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
                        
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            recipeImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            recipeImage.heightAnchor.constraint(equalToConstant: 329),
            recipeImage.widthAnchor.constraint(equalToConstant: 329)
        ])
    }
    
    private func setupRecipeLabel() {
        recipeLabel.textColor = .label
        recipeLabel.font = .systemFont(ofSize: 24, weight: .semibold).rounded
        recipeLabel.numberOfLines = 2

        view.addSubview(recipeLabel)
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 32),
            recipeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            recipeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.textColor = .label
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium).rounded
        descriptionLabel.textColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
        descriptionLabel.numberOfLines = 10

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
}
