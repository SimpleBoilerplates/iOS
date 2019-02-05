//
//  LoginVC.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import SwiftValidator
import UIKit
class SignUpVC: BaseTableViewController {
    @IBOutlet var txtFieldFullName: UITextField!
    @IBOutlet var txtFieldEmailAddress: UITextField!
    @IBOutlet var txtFieldPassWord: UITextField!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnLogin: UIButton!
    let validator = Validator()
    lazy var viewModel: SignUpVM = {
        SignUpVM()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initVM()
    }

    private func setUI() {
        view.backgroundColor = KColor.primary
        tableView.backgroundColor = KColor.primary
    }

    @IBAction func actionSignUp(_: Any) {
        validator.validate(self)
    }

    @IBAction func actionLogin(_: Any) {}

    private func signUP() {
        viewModel.signUp(fullName: txtFieldFullName.text, email: txtFieldEmailAddress.text, password: txtFieldPassWord.text)
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

        viewModel.signedUp = { [weak self] _, _ in
            DispatchQueue.main.async {
                // KeychainWrapper.standard.set(self?.txtFieldEmail.text!, forKey: K.KeyChain.email)
                // KeychainWrapper.standard.set(self?.txtFieldPassword.text!, forKey: K.KeyChain.password)

                //                if(isNew){
                //                    self?.goToProfileTypeVC()
                //                }else{
                //                    self?.goToRoot()
                //                }
            }
        }
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
