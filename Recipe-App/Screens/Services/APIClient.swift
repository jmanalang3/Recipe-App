//
//  APIClient.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 02/10/2020.
//

import Foundation

enum APIClient: APIRouter {
    
    case randomRecipe(number: Int)
    case autoCompleteRecipe(query: String)
    case categories
    
    var path: String {
        switch self {
        case .randomRecipe:
            return "/recipes/random"
        case .autoCompleteRecipe:
            return "/recipes/autocomplete"
        case .categories:
            return "A0CgArX3"
        }
    }
    
    var parameters: [String : Any]? {
        let key = AppConfig.spoonacularKey
        switch self {
        case .randomRecipe(let number):
            return ["apiKey": key,
                    "number": number]
        case .autoCompleteRecipe(let query):
            return ["apiKey": key,
                    "number": 8,
                    "query": query]
        case .categories:
            return nil
        }
    }
    
}




