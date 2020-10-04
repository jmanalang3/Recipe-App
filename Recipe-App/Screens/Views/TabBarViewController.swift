//
//  TabBarViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import UIKit

class TabBarViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
}

// MARK: Setup View

fileprivate extension TabBarViewController {
    
    func setupStructure() {
        
        let recipeListController = RecipeListViewController()
        let searchController = SearchViewController()
        //let savedController = HomeViewControllers()
        
        let receipeListNavigation = UINavigationController(rootViewController: recipeListController)
        let searchNavigation = UINavigationController(rootViewController: searchController)
       // let savedNavigation = UINavigationController(rootViewController: savedController)
        
        viewControllers = [receipeListNavigation, searchNavigation]
    }
    
    func applyTheme() {
        view.backgroundColor = Palette.backgroundColor
    }
    
    func setupBindings() {
        
    }
    
}


// MARK: Private Setup Functionality

fileprivate extension TabBarViewController {
    
}



// MARK: Setup Functionality

extension TabBarViewController {
    
    func reloadData() {

    }
    
}

// MARK: Events Functionality

@objc fileprivate extension TabBarViewController {

    func signOutTapped() {
        do {
            Defaults.clearAll()
            try Auth.auth().signOut()
        } catch {
            Log.e("There was an error signing out.")
        }
    }
}


