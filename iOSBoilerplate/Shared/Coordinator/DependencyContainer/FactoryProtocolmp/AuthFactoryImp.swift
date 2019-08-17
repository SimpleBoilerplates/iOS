//
//  ViewControllerFactoryImp.swift
//  HauteCurator
//
//  Created by Pavle Pesic on 1/18/19.
//  Copyright © 2019 Pavle Pesic. All rights reserved.
//

import UIKit

extension DependencyContainer: AuthFactory {
    
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
