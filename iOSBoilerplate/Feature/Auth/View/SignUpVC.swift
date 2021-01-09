//
//  LoginVC.swift
//  
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import RxCocoa
import RxSwift
import SwiftValidator
import Swinject
import UIKit

protocol SignUpVCProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onSignUp: (() -> Void)? { get set }
    var onSignIn: (() -> Void)? { get set }
}

class SignUpVC: BaseTableViewController, SignUpVCProtocol, AuthStoryboardLodable {
    @IBOutlet var txtFieldFullName: UITextField!
    @IBOutlet var txtFieldEmailAddress: UITextField!
    @IBOutlet var txtFieldPassWord: UITextField!
    @IBOutlet var btnSignUp: UIButton!

    let validator = Validator()

    var signUpViewModel: SignUpViewModel!

    private var disposeBag = DisposeBag()

    // MARK: - SignUpVCProtocol

    var onBack: (() -> Void)?
    var onSignUp: (() -> Void)?
    var onSignIn: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVieModel()
    }

    // MARK: - Overrides

    override func didSelectCustomBackAction() {
        onBack?()
    }

    @IBAction func actionLogin(_: Any) {
        onSignIn?()
    }

    private func signUP() {
        signUpViewModel.signUp()
    }

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

    func bindVieModel() {
       
        bind(textField: txtFieldPassWord, to: signUpViewModel.password)
        bind(textField: txtFieldEmailAddress, to: signUpViewModel.email)
        bind(textField: txtFieldFullName, to: signUpViewModel.fullName)

        signUpViewModel.isValidAll
               .bind(to: btnSignUp.rx.isEnabled)
               .disposed(by: disposeBag)
        
        btnSignUp.rx.tap.asObservable()
               .bind(to: signUpViewModel.signButtonTapped)
               .disposed(by: disposeBag)

        signUpViewModel
            .onShowAlert
            .map { 
                AppHUD.shared.showErrorMessage($0.message ?? "", title: $0.title ?? "")
            }
            .subscribe()
            .disposed(by: disposeBag)

        signUpViewModel
            .onShowingLoading
            .map { [weak self] in
                self?.setLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)

        signUpViewModel
            .onSuccess
            .map { _ in
                self.onSignIn?()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}

// MARK: ValidationDelegate Methods

extension SignUpVC: ValidationDelegate {
    // Private method
    func setUpValidator() {
        validator.registerField(txtFieldFullName, rules: [RequiredRule(), MinLengthRule(length: 5)])
        validator.registerField(txtFieldEmailAddress, rules: [RequiredRule(), EmailRule(), MinLengthRule(length: 5)])
        validator.registerField(txtFieldPassWord, rules: [RequiredRule(), MinLengthRule(length: 5)])
    }

    // ValidationDelegate methods
    func validationSuccessful() {
        signUP()
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
