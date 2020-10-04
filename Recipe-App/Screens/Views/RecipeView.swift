//
//  RecipeView.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 05/10/2020.
//

import Foundation

@IBDesignable
class RecipeView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStructure()
        applyTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStructure()
        applyTheme()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupStructure()
        applyTheme()
    }
    
}

// MARK: Setup View

fileprivate extension RecipeView {
    
    func setupStructure() {
        let viewFromNib = viewFromOwnedNib()
        addSubviewAndFill(viewFromNib)
        
        imageView.contentMode = .scaleAspectFill
        let placeholder = UIImage(named: "recipePlaceholder")
        imageView.image = placeholder
    }
    
    func applyTheme() {}
    
}

// MARK: Setup Functionality

extension RecipeView {
    
    func reloadData() {}
    
    func configure(recipe: FoodRecipe) {
        titleTextField.text = recipe.title
        guard let imageUrl = recipe.imageURL, let url = URL(string: imageUrl) else {
            return
        }
        let placeholder = UIImage(named: "recipePlaceholder")
        let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
        imageView.kf.setImage(with: resource, placeholder: placeholder)
    }
    
}
