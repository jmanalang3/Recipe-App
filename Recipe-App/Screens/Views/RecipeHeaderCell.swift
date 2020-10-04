//
//  RecipeHeaderCell.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

class RecipeHeaderCell: UIView {
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.backgroundColor = .clear
        let placeholder = UIImage(named: "recipePlaceholder")
        imageView.image = placeholder
        return imageView
    }()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.textColor = .black
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Marker Felt", size: 28)
        return label
    }()
    
    let timingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 12)
        return label
    }()
    
    var recipe: FoodRecipe? {
        didSet {
            guard let recipe = recipe else { return }
            recipeTitleLabel.text = recipe.title.unwrappedValue
            timingLabel.text = " Time Required: \(recipe.timeRequired) Minutes"
            if let ingredients = recipe.ingredients {
                ingredientsLabel.text = "  Ingredients (\(ingredients.count) items)"
            } else {
                ingredientsLabel.text = "  Ingredients (\(0) item)"
            }
            if let type = recipe.type {
                typeLabel.text = "  Type (\(type.capitalized))"
            } else {
                typeLabel.text = "  Type (--)"
            }
            guard let imageUrl = recipe.imageURL, let url = URL(string: imageUrl) else {
                return
            }
            let placeholder = UIImage(named: "recipePlaceholder")
            let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
            recipeImageView.kf.setImage(with: resource, placeholder: placeholder)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) as not been implemented")
    }
    
}

fileprivate extension RecipeHeaderCell {
    
    func setupStructure() {
        addSubview(recipeImageView)
        addSubview(recipeTitleLabel)
        addSubview(ingredientsLabel)
        bottomStackView.addArrangedSubview(timingLabel)
        bottomStackView.addArrangedSubview(typeLabel)
        addSubview(bottomStackView)
        setupImageView()
        setupRecipeTitleLabel()
        setupIngredientsLabel()
        setupTimingLabel()
    }
    
    func applyTheme() {
        backgroundColor = .clear
    }
    
    func setupImageView() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupRecipeTitleLabel() {
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setupIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupTimingLabel() {
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomStackView.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupBindings() {
        
    }
    
}

// MARK: Private Setup Functionality

fileprivate extension RecipeHeaderCell {
    
}

// MARK: Setup Functionality

extension RecipeHeaderCell {
    
    func reloadData() {}
    
}

