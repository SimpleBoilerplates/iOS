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
import UIKit

protocol LoginVCProtocol: class {
    var onBack: (() -> Void)? { get set }
    var onLogin: (() -> Void)? { get set }
    var onSignUp: (() -> Void)? { get set }
}

class LoginVC: BaseTableViewController, LoginVCProtocol {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!

    // weak var authCoordinatorDelegate: AuthCoordinatorDelegate?

    private let validator = Validator()
    // private var loginVM: LogInVM!

    lazy var loginVM: LogInVM = assembler.resolver.resolve(LogInVM.self)!

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Overrides

    override func didSelectCustomBackAction() {
        onBack?()
    }

    @IBAction func actionLogin(_: Any) {
        validator.validate(self)
    }

    @IBAction func actionSignUP(_: Any) {
        onSignUp?()
        // authCoordinatorDelegate?.signUp()
    }

    private func login() {
        loginVM.login()
    }

    private func setUI() {}

    private func setLoadingHud(visible: Bool) {
        if visible {
            AppHUD.shared.showHUD()
        } else {
            AppHUD.shared.hideHUD()
        }
    }

    private func bindViewModel() {
        (txtFieldPassword.rx.text <-> loginVM.password).disposed(by: disposeBag)
        (txtFieldEmail.rx.text <-> loginVM.email).disposed(by: disposeBag)

        loginVM.isValid.map {
            $0
        }
        .bind(to: btnLogin.rx.isEnabled)
        .disposed(by: disposeBag)

//        viewModel.onShowAlert.subscribe { (alertMessage) in
//                AppHUD.showErrorMessage(alertMessage.element?.message ?? "", title: alertMessage.element?.title ?? "")
//            }
//            .disposed(by: disposeBag)

//        viewModel.onShowingLoading.subscribe{ (isLoading) in
//            DispatchQueue.main.async {
//                guard let isLoading = isLoading.element else {
//                    return
//                }
//                if isLoading {
//                    AppHUD.showHUD()
//                } else {
//                    AppHUD.hideHUD()
//                }
//            }
//            }.disposed(by: disposeBag)
        ////
//
        loginVM
            .onShowAlert
            .map { [weak self] in
                AppHUD.shared.showErrorMessage($0.message ?? "", title: $0.title ?? "")
            }
            .subscribe()
            .disposed(by: disposeBag)

        loginVM
            .onShowingLoading
            .map { [weak self] in
                self?.setLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)

        loginVM
            .onSuccess
            .map { _ in
                self.onLogin?()
            }
            .subscribe()
            .disposed(by: disposeBag)

//        viewModel.onSuccess.subscribe{ (success) in
//            guard let success = success.element else {
//                return
//            }
//            self.goToRoot()
//        }.disposed(by: disposeBag)
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
