//
//  AppMainContainerView.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

@IBDesignable
class AppMainContainerView: UIView {
    
    @IBOutlet private weak var titleCardView: CardView!
    @IBOutlet private weak var containerCardView: CardView!
    @IBOutlet private weak var bottomStackView: UIStackView!
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var submitButton: UIButton!
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var handleDidSubmitButtonCompletion: ((_ viewModel: ViewModel) -> ())?
    
    indirect enum AnimationState: Int {
        case normal
        case animation
    }
    
    @IBInspectable var stateOutlet: Int {
        get {
            return self.animationState.rawValue
        } set(index) {
            self.animationState = AnimationState(rawValue: index) ?? .normal
        }
    }
    
    var animationState: AnimationState = .animation {
        didSet {
            animationContainerView(animated: animationState == .animation)
        }
    }
    
    indirect enum ViewType: Int {
        case login
        case signUp
    }
    
    var viewType: ViewType = .login {
        didSet {
            showContainer(of: viewType)
        }
    }
    
    indirect enum ViewModel {
        case login(Login)
        case signUp(SignUp)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStructure()
        applyTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStructure()
        applyTheme()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupStructure()
        applyTheme()
    }
    
}

// MARK: Setup View

fileprivate extension AppMainContainerView {
    
    func setupStructure() {
        let viewFromNib = viewFromOwnedNib()
        addSubviewAndFill(viewFromNib)
        
        titleCardView.alpha = 0
        containerCardView.alpha = 0
        bottomStackView.isHidden = true
        
        nameTextField.placeholder = "Name"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        
        animationState = .animation
        
        signUpButton.addTarget(self, action: #selector(handleDidSignUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleDidLoginButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(handleDidSubmitButtonTapped), for: .touchUpInside)
        
    }
    
    func applyTheme() {}
    
}

// MARK: Private Setup Functionality

fileprivate extension AppMainContainerView {
    
    func animationContainerView(animated: Bool) {
        if animated {
            titleCardView.fadeIn()
            bottomStackView.isHidden = false
        } else {
            titleCardView.alpha = 1
            bottomStackView.isHidden = false
        }
    }
    
    func showContainer(of type: ViewType) {
        nameTextField.isHidden = type == .login
        containerCardView.fadeIn()
    }
    
}

// MARK: Setup Functionality

extension AppMainContainerView {
    
    func reloadData() {}
    
}


// MARK: Events Functionality

@objc fileprivate extension AppMainContainerView {
    
    func handleDidSignUpButtonTapped() {
        viewType = .signUp
    }
    
    func handleDidLoginButtonTapped() {
        viewType = .login
    }
    
    func handleDidSubmitButtonTapped() {
        switch viewType {
        case .login:
            guard let email = emailTextField.text,
                  let password = passwordTextField.text else {
                return
            }
            let model = Login(email: email, password: password)
            handleDidSubmitButtonCompletion?(ViewModel.login(model))
        case .signUp:
            guard let name = nameTextField.text,
                  let email = emailTextField.text,
                  let password = passwordTextField.text else {
                return
            }
            let model = SignUp(name: name, email: email, password: password)
            handleDidSubmitButtonCompletion?(ViewModel.signUp(model))
        }
        
    }
    
}


