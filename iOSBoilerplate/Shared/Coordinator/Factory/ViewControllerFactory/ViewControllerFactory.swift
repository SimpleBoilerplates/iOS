//
//  ViewControllerFactory.swift
//  EncoreJets
//
//  Created by Pavle Pesic on 5/24/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

protocol AuthFactory {
    func instantiateLoginVC() -> LoginVC
    func instantiateSignUpVC() -> SignUpVC
}

protocol HomeFactory {
    func instantiateHomeVC() -> HomeVC
    func instantiateBookDetailVC(viewModel: BookDetailVM) -> BookDetailVC

}


