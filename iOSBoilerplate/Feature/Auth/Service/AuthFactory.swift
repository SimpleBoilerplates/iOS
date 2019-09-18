//
//  ViewControllerFactoryImp.swift
//

import UIKit

protocol AuthFactory {
    func instantiateLoginVC() -> LoginVC
    func instantiateSignUpVC() -> SignUpVC
}

extension CoordinatorContainer: AuthFactory {

    func instantiateLoginVC() -> LoginVC {
        let vc = UIStoryboard.storyboard(storyboard: .Auth).instantiateViewController(LoginVC.self)
        //vc.viewModel = ChooseLoginRegisterViewModel()
        return vc
    }

    func instantiateSignUpVC() -> SignUpVC {
        let vc = UIStoryboard.storyboard(storyboard: .Auth).instantiateViewController(SignUpVC.self)
        //vc.viewModel = LoginViewModel(authServices: self.authNetworkServices)
        return vc
    }


}
