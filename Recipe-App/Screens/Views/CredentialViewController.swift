//
//  CredentialViewController.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

class CredentialViewController: UIViewController {
    
    private let container = AppMainContainerView()
    
    private let viewModel = AuthenticationViewModel()
    private let disposeBag = DisposeBag()
        
    override func loadView() {
        view = container
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStructure()
        applyTheme()
        setupBindings()
    }
    
}

// MARK: Setup View

fileprivate extension CredentialViewController {
    
    func setupStructure() {

    }
    
    func applyTheme() {

    }
    
    func setupBindings() {
        
        /// View Model binding
        viewModel
            .onSuccess
            .map { [weak self] in self?.showTabBarViewController()}
            .subscribe()
            .disposed(by: disposeBag)
        
        
        viewModel
            .onShowError
            .map { [weak self] in self?.presentSingleButtonDialog(alert: $0)}
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel
            .onShowLoadingHud
            .map { [weak self] in self?.setLoadingHud(visible: $0) }
            .subscribe()
            .disposed(by: disposeBag)
        

        /// Views binding
        container.handleDidSubmitButtonCompletion = { [weak self] model in
            switch model {
            case .login(let model):
                self?.viewModel.signInUser(login: model)
            case .signUp(let model):
                self?.viewModel.signUpUser(signUp: model)
            }
        }
        
    }

}

// MARK: Private Setup Functionality

fileprivate extension CredentialViewController {
    
    func setLoadingHud(visible: Bool) {
        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    func showTabBarViewController() {
        UIApplication.shared.windows.first?.rootViewController = TabBarViewController()
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

// MARK: Setup Functionality

extension CredentialViewController {
    
    func reloadData() {}
    
}
