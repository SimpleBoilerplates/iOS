//
//  WalktroughViewControllerFactoryImp.swift


import UIKit

protocol HomeFactory {
    func instantiateHomeVC() -> HomeVC
    func instantiateBookDetailVC(viewModel: BookDetailVM) -> BookDetailVC

}

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
