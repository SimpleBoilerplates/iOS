//
//  HomeCoordinator.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/15/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: class {
    func stop()
    func bookSelected(bookVM : BookVM)
}

final class HomeCoordinator: Coordinator {
   
    var appCoordinator: AppCoordinator?
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
    }
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?) {
        self.init(navigationController: navigationController)
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        let vc = UIStoryboard.storyboard(storyboard: .Home).instantiateViewController(HomeVC.self)
        vc.homeCoordinatorDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func stop() {
        _ = navigationController?.popViewController(animated: true)
        appCoordinator?.homeCoordinatorCompleted(coordinator: self)
    }
    func bookSelected( bookVM : BookVM)  {
        let vc = UIStoryboard.storyboard(storyboard: .Home).instantiateViewController(BookDetailVC.self)
        vc.homeCoordinatorDelegate = self
        vc.viewModel = BookDetailVM(bookVM: bookVM)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeCoordinator : HomeCoordinatorDelegate{
    
    
}
