//
//  WalktroughCoordinator.swift
//  HauteCurator
//
//  Created by Pavle Pesic on 1/22/19.
//  Copyright © 2019 Pavle Pesic. All rights reserved.
//

import Foundation

final class HomeCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    private let router: RouterProtocol
    private let factory: Factory
    
    // MARK: - Private metods
    
    private func showHomeVC() {
        let vc = self.factory.instantiateHomeVC()
        vc.onSignOut = {
            self.runAuthFlow()
        }
        self.router.push(vc)
    }
    private func showBookDetailVC(viewModel: BookDetailVM) {
        let vc = self.factory.instantiateBookDetailVC(viewModel: viewModel)
        vc.onBack = { [unowned self] in
            self.router.popModule()
        }
        self.router.push(vc)
    }
    private func runAuthFlow() {
        let coordinator = self.factory.instantiateAuthCoordinator(router: self.router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            //self.launchInstructor = LaunchInstructor.configure(isAutorized: AuthHelper.Auth().isLoggedIn)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Coordinator
    override func start() {
        self.showHomeVC()
    }
    
    // MARK: - Init
    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }
    
}
