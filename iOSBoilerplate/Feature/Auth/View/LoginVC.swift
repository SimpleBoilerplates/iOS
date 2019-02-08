//
//  LoginVC.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import SwiftValidator
import UIKit

class LoginVC: BaseTableViewController {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!

    let validator = Validator()
    lazy var viewModel: LogInVM = {
        LogInVM()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValidator()
        setUI()
        initVM()
    }

    @IBAction func actionLogin(_: Any) {
        validator.validate(self)
    }

    @IBAction func actionSignUP(_: Any) {}

    func login() {
        viewModel.login(email: txtFieldEmail.text, password: txtFieldPassword.text)
    }

    private func setUI() {
        view.backgroundColor = KColor.primary
        tableView.backgroundColor = KColor.primary

//        if let email = KeychainWrapper.standard.string(forKey: K.KeyChain.email), let password = KeychainWrapper.standard.string(forKey: K.KeyChain.password) {
//            txtFieldEmail.text = email
//            txtFieldPassword.text = password
//        }
    }

    func initVM() {
        viewModel.showError = { alert in
            DispatchQueue.main.async {
                AppHUD.showErrorMessage(alert.message ?? "", title: alert.title ?? "")
            }
        }

        viewModel.showLoadingHUD = { isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    AppHUD.showHUD()
                } else {
                    AppHUD.hideHUD()
                }
            }
        }

        viewModel.signedIn = { [weak self] success, _ in
            DispatchQueue.main.async {
                if success {
                    self?.goToRoot()
                }
            }
        }
    }
}

// MARK: ValidationDelegate Methods

extension LoginVC: ValidationDelegate {
    // Private method
    func setUpValidator() {
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
