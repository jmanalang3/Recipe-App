//
//  RecipeViewModel.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation

enum RecipeViewCellType {
    case normal(foodRecipe: FoodRecipe)
    case error(message: String)
    case empty
}

final class RecipeViewModel {
    
    private let appServerClient: AppServerClient
    private let disposeBag = DisposeBag()

    let recipesTypes = PublishSubject<[RecipeType]>()
    
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    var recipes: Observable<[RecipeViewCellType]> {
        return recipeItems.asObservable()
    }
    
    private let loadInProgress = BehaviorRelay(value: false)
    private let recipeItems = BehaviorRelay<[RecipeViewCellType]>(value: [])
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func loadRecipeTypes() {
        guard let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") else {
            Log.e("recipetypes data is empty")
            return
        }
        let xml = RecipeTypeXML(contentsOf: path)
        DispatchQueue.main.async {
            self.recipesTypes.onNext(xml.recipeTypes)
        }
    }
    
    func getRandomRecipeFilter(by name: String, number: Int = 8) {
        guard Defaults.isFirstTimeUser == nil || Defaults.isFirstTimeUser == false else {
           fetchedResultsFilter(by: name)
            return
        }
        loadInProgress.accept(true)
        Defaults.isFirstTimeUser = true
        Defaults.synchronize()
        appServerClient.fetchRandomRecipe(number: number).subscribe(onNext: { [weak self] data in
            self?.loadInProgress.accept(false)
            let context = CoreDataManager.mainContext
            data.forEach {
                let obj = FoodRecipe(context: context)
                obj.save(recipe: $0, context: context)
            }
            CoreDataManager.persist()
            self?.fetchedResultsFilter(by: name)
        }, onError: { [weak self] error in
            self?.fetchedResultsFilter(by: name)
        }).disposed(by: disposeBag)
    }
    
}

fileprivate extension RecipeViewModel {
    
    func fetchedResultsFilter(by name: String) {
        let context = CoreDataManager.mainContext
        let fetchRequest = FoodRecipe.fetchingRequest(value: name)
        do {
            let results = try context.fetch(fetchRequest)
            guard results.count > 0 else {
                self.recipeItems.accept([.empty])
                return
            }
            self.recipeItems.accept(results.compactMap { .normal(foodRecipe: $0) } )
        }catch{
            self.recipeItems.accept([.error(message: error.localizedDescription)])
        }
    }
    
}

extension RecipeViewModel {
    

}








