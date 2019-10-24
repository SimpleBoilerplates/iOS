//
//  LoginVC.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import RxCocoa
import RxSwift
import SwiftValidator
import Swinject
import UIKit

protocol LoginVCProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onLogin: (() -> Void)? { get set }
    var onSignUp: (() -> Void)? { get set }
}

class LoginVC: BaseTableViewController, LoginVCProtocol, AuthStoryboardLodable {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!

    private let validator = Validator()

    var loginViewModel: LogInViewModel!

    // MARK: - LoginVCProtocol

    var onBack: (() -> Void)?
    var onLogin: (() -> Void)?
    var onSignUp: (() -> Void)?

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValidator()
        setUI()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Overrides

    override func didSelectCustomBackAction() {
        onBack?()
    }

    @IBAction func actionLogin(_: Any) {
        //validator.validate(self)
    }

    @IBAction func actionSignUP(_: Any) {
        onSignUp?()
    }

    private func login() {
        loginViewModel.login()
    }

    private func setUI() {}

    private func setLoadingHud(visible: Bool) {
        if visible {
            AppHUD.shared.showHUD()
        } else {
            AppHUD.shared.hideHUD()
        }
    }
    
    private func bind(textField: UITextField, to behaviorRelay: BehaviorRelay<String>) {
         behaviorRelay.asObservable()
             .bind(to: textField.rx.text)
             .disposed(by: disposeBag)
         textField.rx.text.orEmpty
             .bind(to: behaviorRelay)
             .disposed(by: disposeBag)
     }

    private func bindViewModel() {
        
        bind(textField: txtFieldPassword, to: loginViewModel.password)
        bind(textField: txtFieldEmail, to: loginViewModel.email)

        loginViewModel.isValidAll
        .bind(to: btnLogin.rx.isEnabled)
        .disposed(by: disposeBag)
        
        
        btnLogin.rx.tap.asObservable()
        .bind(to: loginViewModel.loginButtonTapped)
        .disposed(by: disposeBag)
        
        loginViewModel
            .onShowAlert
            .map { 
                AppHUD.shared.showErrorMessage($0.message ?? "", title: $0.title ?? "")
            }
            .subscribe()
            .disposed(by: disposeBag)

        loginViewModel
            .onShowingLoading
            .map { [weak self] in
                self?.setLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)

        loginViewModel
            .onSuccess
            .map{ [weak self] isSuccess in

            guard let self = self else {
                return
            }
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.onLogin?()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}

// MARK: ValidationDelegate Methods

extension LoginVC: ValidationDelegate {
    // Private method
    private func setUpValidator() {
        validator.registerField(txtFieldEmail, rules: [RequiredRule(), EmailRule(), MinLengthRule(length: 5)])
        validator.registerField(txtFieldPassword, rules: [RequiredRule(), MinLengthRule(length: 5)])
    }

    // ValidationDelegate methods
    func validationSuccessful() {
        login()
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
}
