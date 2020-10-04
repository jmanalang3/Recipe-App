//
//  DetailViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

class DetailViewController: UIViewController {
    
    private let containerView = UIView()
    private var addBarButton: UIBarButtonItem!
    private let stackView = UIStackView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let actionButton = UIButton()
    
    fileprivate enum ViewId: String {
        case cell = "cell"
    }
    
    private var recipe: FoodRecipe
    private let disposeBag = DisposeBag()
    
    init(recipe: FoodRecipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}

// MARK: Setup View

fileprivate extension DetailViewController {
    
    func setupStructure() {
        
        setupBarButtonItem()
        setupInstructionButton()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(actionButton)
        
        tabBarController?.tabBar.isHidden = true
        
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewId.cell.rawValue)
        
    }
    
    func applyTheme() {
        tableView.backgroundColor = Palette.backgroundColor
    }
    
    func setupBindings() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    func setupBarButtonItem() {
        addBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipeTapped))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    func setupInstructionButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        actionButton.setTitle("Update", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = #colorLiteral(red: 0.3259045561, green: 0.6834023016, blue: 1, alpha: 1)
        actionButton.addTarget(self, action: #selector(showUpdateAction), for: .touchUpInside)
    }
    
}

// MARK: Private Setup Functionality

fileprivate extension DetailViewController {
    
    func setLoadingHud(visible: Bool) {
        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
}

// MARK: Setup Functionality

extension DetailViewController {
    
    func reloadData() {}
    
    func createHeaderView() -> RecipeHeaderCell {
        let headerView = RecipeHeaderCell()
        headerView.recipe = recipe
        return headerView
    }
    
}

// MARK: Events Functionality

@objc fileprivate extension DetailViewController {
    
    func addRecipeTapped() {
        
    }
    
    func showUpdateAction() {
        let controller = RecipeViewController(recipe: recipe)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = recipe.ingredients else { return 0 }
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewId.cell.rawValue) else {
            return UITableViewCell()
        }
        guard let ingredients = recipe.ingredients else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Verdana", size: 16)
        if let object = ingredients.allObjects[indexPath.row] as? Ingredient {
            cell.textLabel?.text = "\(indexPath.row + 1). \(object.ingredient.unwrappedValue)"
        }
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = createHeaderView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
