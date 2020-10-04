//
//  Recipe.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation

struct RecipeType {
    var title: String
}

struct Recipe: Codable {
    var title : String?
    var dishTypes: [String]?
    var image: String?
    var readyInMinutes: Int?
    var sourceURL: String?
    var extendedIngredients: [ExtendedIngredient]?
    var analyzedInstructions: [AnalyzedInstruction]?
    var servings: Int?
}

struct RecipeResponse: Codable {
    var recipes: [Recipe]?
}

struct AutoCompleteSearchResponse: Codable {
    let id: Int
    let title: String
}

struct ExtendedIngredient: Codable {
    let originalString: String?
}

struct AnalyzedInstruction: Codable {
    let originalString: String?
    let steps: [Step]?
}

struct Step: Codable {
    let step: String?
}




