//
//  AuthenticationViewModel.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

final class AuthenticationViewModel {
    
    private let appServerClient: AppServerClient
    private let disposeBag = DisposeBag()
    
    let onSuccess = PublishSubject<Void>()
    let onShowError = PublishSubject<SingleButtonAlert>()
    
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    private let loadInProgress = BehaviorRelay(value: false)
        
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func signInUser(login model: Login) {
        loadInProgress.accept(true)
        appServerClient.signInUser(withEmail: model.email, password: model.password).subscribe(onNext: { [weak self] in
            self?.loadInProgress.accept(false)
            self?.onSuccess.onNext(())
        }, onError: { [weak self] error in
            self?.loadInProgress.accept(false)
            let alert = SingleButtonAlert(title: "Authentication",
                                          message: error.localizedDescription,
                                          action: AlertAction(buttonTitle: "Ok", handler: {
                                            Log.d("Ok pressed!")
            }))
            self?.onShowError.onNext(alert)
        }).disposed(by: disposeBag)
    }
    
    
    func signUpUser(signUp model: SignUp) {
        loadInProgress.accept(true)
        appServerClient.signUpUser(withEmail: model.email, password: model.password).subscribe(onNext: { [weak self] in
            self?.loadInProgress.accept(false)
            self?.onSuccess.onNext(())
        }, onError: { [weak self] error in
            self?.loadInProgress.accept(false)
            let alert = SingleButtonAlert(title: "Authentication",
                                          message: error.localizedDescription,
                                          action: AlertAction(buttonTitle: "Ok", handler: {
                                            Log.d("Ok pressed!")
            }))
            self?.onShowError.onNext(alert)
        }).disposed(by: disposeBag)
    }

}


// declaration of local variables
struct defaultsKeys {
    static let keyOne = "emailKey"
    static let keyTwo = "nameKey"
    static let keyThree = "dietPreferenceKey"
    static let keyFour = "dietRestrictionKey"
}


//
//let user = Auth.auth().currentUser;
//let uid = user?.uid
//
//// create database reference
//let databaseRef = Database.database().reference()
//// write data to database using reference
//databaseRef.child("Users").child("\(uid!)/Name").setValue("jeffrey")
//databaseRef.child("Users").child("\(uid!)/Email").setValue(user?.email)
//databaseRef.child("Users").child("\(uid!)/NumHistory").setValue(0)
//databaseRef.child("Users").child("\(uid!)/NumSaved").setValue(0)
//databaseRef.child("Users").child("\(uid!)/DietPreference").setValue("None")
//databaseRef.child("Users").child("\(uid!)/DietRestriction").setValue("None")
//
//// save important data locally
//let defaults = UserDefaults.standard
//defaults.set(user?.email, forKey: defaultsKeys.keyOne)
//defaults.set("self.nameField.text", forKey: defaultsKeys.keyTwo)
