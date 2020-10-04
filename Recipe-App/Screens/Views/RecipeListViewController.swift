//
//  RecipeListViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    private var addBarButton: UIBarButtonItem!
    private let stackView = UIStackView()
    private let pickerView = UIPickerView()
    private let tableView = UITableView()
    
    fileprivate enum ViewId: String {
        case cell = "cell"
    }
    
    private var viewModel = RecipeViewModel()
    private let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Home"
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage(named: "home")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}

// MARK: Setup View

fileprivate extension RecipeListViewController {
    
    func setupStructure() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(pickerView)
        stackView.addArrangedSubview(tableView)
        
        tableView.bounces = false
        tableView.rowHeight = 120
        tableView.keyboardDismissMode = .onDrag
        tableView.register(RecipeCell.self, forCellReuseIdentifier: ViewId.cell.rawValue)
        
        pickerView.accessibilityNavigationStyle = .combined
        
        setupBarButtonItem()
    }
    
    func applyTheme() {
        tableView.backgroundColor = .clear
    }
    
    func setupBindings() {
        
        /// View Model binding
        viewModel
            .onShowLoadingHud
            .map { [weak self] in self?.setLoadingHud(visible: $0) }
            .subscribe()
            .disposed(by: disposeBag)
        
        /// Picker View
        viewModel.recipesTypes.bind(to: pickerView.rx.itemAttributedTitles) { _, model in
            return self.pickerAttributedText(model: model)
        }.disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(RecipeType.self).subscribe(onNext: { [weak self] models in
            guard let name = models.first?.title.lowercased() else { return }
            self?.viewModel.getRandomRecipeFilter(by: name, number: 10)
        }).disposed(by: disposeBag)
        
        /// Table View
        viewModel.recipes.bind(to: self.tableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normal(let recipe):
                let cell = tableView.dequeueReusableCell(withIdentifier: ViewId.cell.rawValue, for: indexPath)
                guard let rawCell = cell as? RecipeCell else {
                    return UITableViewCell()
                }
                rawCell.recipe = recipe
                return cell
            case .error(let message):
                let cell = UITableViewCell()
                cell.show(message: message)
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.show(message: "No data available")
                return cell
            }
        }.disposed(by: disposeBag)
        
        
        tableView.rx
            .modelSelected(RecipeViewCellType.self)
            .subscribe(
                onNext: { [weak self] cellType in
                    if case let .normal(recipe) = cellType {
                        let controller = DetailViewController(recipe: recipe)
                        self?.navigationController?.pushViewController(controller, animated: true)
                    }
                    if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
                        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }
            ).disposed(by: disposeBag)
        
        viewModel.loadRecipeTypes()
        viewModel.getRandomRecipeFilter(by: "side dish", number: 20)
    }
    
    func setupBarButtonItem() {
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipeTapped))
        navigationItem.leftBarButtonItem = addBarButton
    }
    
}

// MARK: Private Setup Functionality

fileprivate extension RecipeListViewController {
    
    func setLoadingHud(visible: Bool) {
        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    func pickerAttributedText(model: RecipeType) -> NSAttributedString {
        return NSAttributedString(string: "\(model.title.capitalized)",
                                  attributes: [
                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
                                  ])
    }
    
}

// MARK: Setup Functionality

extension RecipeListViewController {
    
    func reloadData() {
        tableView.reloadData()
        pickerView.reloadAllComponents()
    }
    
}

// MARK: Events Functionality

@objc fileprivate extension RecipeListViewController {
    
    func addRecipeTapped() {
//        let controller = RecipeViewController()
//        navigationController?.pushViewController(controller, animated: true)
    }
    
}
