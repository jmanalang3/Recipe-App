//
//  AppServerClient.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

class AppServerClient  {}

// MARK: Authentication

extension AppServerClient {
    
    func signInUser(withEmail email: String, password: String) -> Observable<Void> {
        return Observable<Void>.create { observer -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let rawError = error {
                    observer.onError(rawError)
                } else {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
    }
    
    func signUpUser(withEmail email: String, password: String) -> Observable<Void> {
        return Observable<Void>.create { observer -> Disposable in
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let rawError = error {
                    observer.onError(rawError)
                } else {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
    }
    
}

// MARK: Recipe

extension AppServerClient {
    
    func fetchRandomRecipe(number: Int = 8) -> Observable<[Recipe]> {
        return Observable<[Recipe]>.create { observer -> Disposable in
            let request = AF.request(APIClient.randomRecipe(number: number))
            request.responseDecodable(of: RecipeResponse.self) { (response) in
                if let error = response.error {
                    observer.onError(error)
                    return
                }
                guard let recipes = response.value?.recipes else {
                    observer.onNext([])
                    return
                }
                observer.onNext(recipes)
            }
            return Disposables.create()
        }

    }

}
