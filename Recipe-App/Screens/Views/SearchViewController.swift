//
//  SearchViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    private var homeViewModel = RecipeViewModel()
    private let disposeBag = DisposeBag()
    
    fileprivate enum ViewId: String {
        case cell = "cell"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem.title = "Search"
        tabBarItem.image = UIImage(named: "search")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
}

// MARK: Setup View

fileprivate extension SearchViewController {
    
    func setupStructure() {
        seatupSearchBar()
        setupTableView()
    }
    
    func applyTheme() {
        view.backgroundColor = .white
    }
    
    func seatupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchBar.placeholder = "Search"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewId.cell.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

// MARK: Private Setup Functionality

fileprivate extension SearchViewController {
    
    func setupBindings() {
    
//        // Search Bar Binding
//        
//        searchBar.rx.text
//            .subscribe(onNext: { [weak self] query in
//                self?.homeViewModel.searchRecipeAutocomplete(query: query ?? "")
//            }).disposed(by: self.disposeBag)
//        
//        
//        // TableView Binding
//        
//        let observable = homeViewModel.error.observeOn(MainScheduler.instance)
//        observable.subscribe {
//            print("Manalang MVVM RXswift test error message \(String(describing: $0.element?.localizedDescription))")
//        }.disposed(by: disposeBag)
//        
//        let handler = homeViewModel.searchRecipe.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self))
//        handler { row, element, cell in
//            cell.textLabel?.text = "\(String(describing: element.title)) @ row \(row)"
//        }.disposed(by: disposeBag)
//        
//        tableView.rx.modelSelected(AutoCompleteSearchResponse.self).subscribe { value in
//            print("Tapped `\(value)`")
//        }.disposed(by: disposeBag)
    }
    
}

// MARK: Setup Functionality

extension SearchViewController {
    
    func reloadData() {}
    
}






