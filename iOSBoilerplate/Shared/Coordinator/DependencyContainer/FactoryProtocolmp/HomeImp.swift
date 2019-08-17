//
//  WalktroughViewControllerFactoryImp.swift
//  HauteCurator
//
//  Created by Pavle Pesic on 1/26/19.
//  Copyright © 2019 Pavle Pesic. All rights reserved.
//

import UIKit

extension DependencyContainer: HomeFactory {

    func instantiateHomeVC() -> HomeVC {
        let vc = UIStoryboard.storyboard(storyboard: .Home).instantiateViewController(HomeVC.self)
        return vc
    }
    
    func instantiateBookDetailVC(viewModel: BookDetailVM) -> BookDetailVC {
        let vc = UIStoryboard.storyboard(storyboard: .Home).instantiateViewController(BookDetailVC.self)
        vc.viewModel = viewModel
        return vc
    }
    
}
