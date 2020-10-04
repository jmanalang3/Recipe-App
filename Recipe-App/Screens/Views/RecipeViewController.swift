//
//  AddRecipeViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 05/10/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    private var containerView = RecipeView()
    
    private var viewModel: RecipeViewModel
    private let disposeBag = DisposeBag()
    
    private var recipe: FoodRecipe

    
    init(recipe: FoodRecipe, viewModel: RecipeViewModel = RecipeViewModel()) {
        self.recipe = recipe
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = recipe.title
        self.containerView.configure(recipe: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }

    override func loadView() {
        view = containerView
    }
        
}

// MARK: Setup View

fileprivate extension RecipeViewController {
    
    func setupStructure() {
    }
    
    func applyTheme() {
        view.backgroundColor = Palette.backgroundColor
    }
    
    func setupBindings() {
        viewModel.loadRecipeTypes()
        
        /// Picker View
        viewModel.recipesTypes.bind(to: containerView.pickerView.rx.itemAttributedTitles) { _, model in
            return self.pickerAttributedText(model: model)
        }.disposed(by: disposeBag)
    }
    
}

// MARK: Private Setup Functionality

fileprivate extension RecipeViewController {
    
    func setLoadingHud(visible: Bool) {
        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    func pickerAttributedText(model: RecipeType) -> NSAttributedString {
        return NSAttributedString(string: "\(model.title.capitalized)",
                                  attributes: [
                                    NSAttributedString.Key.foregroundColor: UIColor.black,
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
                                  ])
    }
    
}

// MARK: Setup Functionality

extension RecipeViewController {
    
    func reloadData() {}
    
}

// MARK: Events Functionality

@objc fileprivate extension RecipeViewController {
    
    func addRecipeTapped() {
        
    }
    
}
