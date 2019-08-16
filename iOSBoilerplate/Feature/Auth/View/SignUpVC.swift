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

class SignUpVC: BaseTableViewController {
    @IBOutlet var txtFieldFullName: UITextField!
    @IBOutlet var txtFieldEmailAddress: UITextField!
    @IBOutlet var txtFieldPassWord: UITextField!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnLogin: UIButton!
    let validator = Validator()

    weak var authCoordinatorDelegate: AuthCoordinatorDelegate?

    lazy var viewModel: SignUpVM = {
        SignUpVM()
    }()

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindVieModel()
    }

    private func setUI() {
//        view.backgroundColor = KColor.primary
//        tableView.backgroundColor = KColor.primary
    }

    @IBAction func actionSignUp(_: Any) {
        validator.validate(self)
    }

    @IBAction func actionLogin(_: Any) {
        authCoordinatorDelegate?.signIn()
    }

    private func signUP() {
        viewModel.signUp()
    }

    private func setLoadingHud(visible: Bool) {
        if visible {
            AppHUD.showHUD()
        } else {
            AppHUD.hideHUD()
        }
    }

    func bindVieModel() {
        (txtFieldPassWord.rx.text <-> viewModel.password).disposed(by: disposeBag)
        (txtFieldEmailAddress.rx.text <-> viewModel.email).disposed(by: disposeBag)
        (txtFieldFullName.rx.text <-> viewModel.fullName).disposed(by: disposeBag)

        viewModel.isValid.map {
                    $0
                }
                .bind(to: btnLogin.rx.isEnabled)
                .disposed(by: disposeBag)

        viewModel
                .onShowAlert
                .map { [weak self] in
                    AppHUD.showErrorMessage($0.message ?? "", title: $0.title ?? "")
                }
                .subscribe()
                .disposed(by: disposeBag)

        viewModel
                .onShowingLoading
                .map { [weak self] in
                    self?.setLoadingHud(visible: $0)
                }
                .subscribe()
                .disposed(by: disposeBag)

//        viewModel.alertMessage.subscribe { (alertMessage) in
//            AppHUD.showErrorMessage(alertMessage.element?.message ?? "", title: alertMessage.element?.title ?? "")
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.isLoading.subscribe{ (isLoading) in
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

        viewModel
                .onSuccess
                .map { _ in
                    self.authCoordinatorDelegate?.signIn()
                }
                .subscribe()
                .disposed(by: disposeBag)
//        viewModel.onSuccess.subscribe{ (success) in
//            guard let success = success.element else {
//                return
//            }
//            self.goToLoginVC()
//            }.disposed(by: disposeBag)
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
