//
//  RecipeCollectionViewCell.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties (view)
    
    private let recipeImage = UIImageView()
    private let recipeLabel = UILabel()
    private let ratingAndDifficultyLabel = UILabel()
     
    static let reuse = "RecipeCollectionViewCellReuse"
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        setupRecipeImage()
        setupRecipeLabel()
        setupRatingAndDifficultyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(recipe: Recipe) {
        recipeImage.sd_setImage(with: URL(string: recipe.imageUrl))
        recipeLabel.text = recipe.name
        ratingAndDifficultyLabel.text = String(recipe.rating) + " - " + recipe.difficulty
    }
    
    private func setupRecipeImage() {
        recipeImage.layer.cornerRadius = 10
        recipeImage.layer.masksToBounds = true
        
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        
        contentView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
                        
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            recipeImage.heightAnchor.constraint(equalToConstant: 148),
            recipeImage.widthAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    private func setupRecipeLabel() {
        recipeLabel.textColor = .label
        recipeLabel.font = .systemFont(ofSize: 16, weight: .semibold).rounded
        recipeLabel.numberOfLines = 2

        
        contentView.addSubview(recipeLabel)
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupRatingAndDifficultyLabel() {
        ratingAndDifficultyLabel.textColor = .label
        ratingAndDifficultyLabel.font = .systemFont(ofSize: 12, weight: .regular).rounded
        ratingAndDifficultyLabel.textColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
        
        contentView.addSubview(ratingAndDifficultyLabel)
        ratingAndDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingAndDifficultyLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 4),
            ratingAndDifficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        ])
    }
}
