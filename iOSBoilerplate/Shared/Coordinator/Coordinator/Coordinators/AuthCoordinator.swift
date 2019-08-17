//
//  AuthCoordinator.swift
//  HauteCurator
//
//  Created by Pavle Pesic on 1/18/19.
//  Copyright © 2019 Pavle Pesic. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let factory: Factory
    
    // MARK: - Private methods
   
    private func showLoginVC() {
        let vc = self.factory.instantiateLoginVC()
        vc.onBack = { [unowned self] in
            self.router.popModule(transition: FadeAnimator(animationDuration: 0.2, isPresenting: false))
        }
        vc.onLogin = {
            self.runHomeFlow()
        }
        vc.onSignUp = {
            self.showSignUpVC()
        }
        self.router.push(vc, transition: FadeAnimator(animationDuration: 0.2, isPresenting: true))
    }
    
    private func showSignUpVC() {
        let vc = self.factory.instantiateSignUpVC()
         vc.onBack = { [unowned self] in
            self.router.popModule()
        }
        vc.onSignUp = {
            self.router.popModule()
            //self.runHomeFlow()
        }
        self.router.push(vc)
    }
 
    private func runHomeFlow() {
        let coordinator = self.factory.instantiateHomeCoordinator(router: self.router)
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
        self.showLoginVC()
    }
    
    // MARK: - Init
    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }
    
}
