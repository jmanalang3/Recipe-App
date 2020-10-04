//
//  FoodRecipe+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

extension FoodRecipe {
    
    func save(recipe: Recipe, context: NSManagedObjectContext){
        
        self.title = recipe.title
        self.imageURL = recipe.image
        self.sourceURL = recipe.sourceURL
        self.timeRequired = recipe.readyInMinutes.unwrappedValue.int64
        
        
        self.type = recipe.dishTypes?.first.unwrappedValue
        
//        recipe.dishTypes?.forEach {
//            let dishType = DishType(context: context)
//            dishType.name = $0
//
//        }
        
        recipe.extendedIngredients?.forEach {
            let extendedIngredient = Ingredient(context: context)
            extendedIngredient.ingredient = $0.originalString
            extendedIngredient.foodRecipe = self
        }
        
        var count = 1
        recipe.analyzedInstructions?.forEach {
            let instruction = Instruction(context: context)
            instruction.instruction = $0.originalString
            instruction.foodRecipe = self
            instruction.stepNumber = Int64(count)
            count += 1
        }
        
    }
    
    static func fetchingRequest(value: String) -> NSFetchRequest<FoodRecipe> {
        let titleKey = #keyPath(FoodRecipe.title)
        let typeKey = #keyPath(FoodRecipe.type)
        let predicate = NSPredicate(format: "%K == %@", typeKey, value)
        let sortDescriptors = [NSSortDescriptor(key:"\(titleKey)", ascending: true)]
        let context = CoreDataManager.mainContext
        let fetchRequest = CoreDataManager.fetchRequest(entity: self, predicate: predicate,
                                                        sortDescriptors: sortDescriptors, context: context)
        return fetchRequest
    }
    
    
    
}


