//
//  RecipeCell.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Marker Felt", size: 20)
        return label
    }()
    
    let durationTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    var recipe: FoodRecipe? {
        didSet {
            guard let recipe = recipe else { return }
            recipeTitleLabel.text = recipe.title.unwrappedValue
            durationTitleLabel.text = String("\(recipe.timeRequired) minutes")
            guard let imageUrl = recipe.imageURL, let url = URL(string: imageUrl) else {
                return
            }
            let placeholder = UIImage(named: "recipePlaceholder")
            let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
            recipeImageView.kf.setImage(with: resource, placeholder: placeholder)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension RecipeCell {
    
    func setupStructure() {
        setupRecipeImageView()
        setupRecipeTitle()
        setupDurationTitle()
    }
    
    func applyTheme() {
        backgroundColor = .clear
    }
    
    func setupRecipeImageView() {
        addSubview(recipeImageView)
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 109).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 109).isActive = true
        recipeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupRecipeTitle() {
        addSubview(recipeTitleLabel)
        
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 8).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        recipeTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupDurationTitle() {
        addSubview(durationTitleLabel)
        
        durationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        durationTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 5).isActive = true
        durationTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        durationTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        durationTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupBindings() {

    }
    
}

// MARK: Private Setup Functionality

fileprivate extension RecipeCell {
        
}

// MARK: Setup Functionality

extension RecipeCell {
    
    func reloadData() {}
    
}

