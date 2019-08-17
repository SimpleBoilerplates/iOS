//
//  AuthCoordinator.swift

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
            self.router.popModule()
        }
        vc.onLogin = {
            self.finishFlow?()
        }
        vc.onSignUp = {
            self.showSignUpVC()
        }
        self.router.push(vc)
    }

    private func showSignUpVC() {
        let vc = self.factory.instantiateSignUpVC()
        vc.onBack = { [unowned self] in
            self.router.dismissModule()
        }
        vc.onSignUp = {
            self.router.dismissModule()
        }
        vc.onSignIn = {
            self.router.dismissModule()
        }
        self.router.present(vc)
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
