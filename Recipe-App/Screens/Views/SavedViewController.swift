//
//  SavedViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import UIKit

class SavedViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var homeViewModel = RecipeViewModel()
    private let disposeBag = DisposeBag()
    
    fileprivate enum ViewId: String {
        case cell = "cell"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage(named: "home")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
}

// MARK: Setup View

fileprivate extension SavedViewController {
    
    func setupStructure() {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewId.cell.rawValue)
    }
    
    func applyTheme() {
        view.backgroundColor = .white
    }
    

}


// MARK: Private Setup Functionality

fileprivate extension SavedViewController {
    
    func setupBindings() {
        
    }
    
}


// MARK: Setup Functionality

extension SavedViewController {
    
    func reloadData(){
        tableView.reloadData()
    }
    
}




