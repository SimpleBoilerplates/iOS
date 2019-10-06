//
//  AuthCoordinator.swift

//

import Swinject
import UIKit

enum AuthChildCoordinator {
    case about
}

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    let navigationController: CoordinatorNavigationController
    let container: Container
    // private var childCoordinators = [AuthChildCoordinator: Coordinator]()

    // MARK: - Coordinator

    override func start() {
        showLoginVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: CoordinatorNavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private methods

    private func showLoginVC() {
        let vc = container.resolveViewController(LoginVC.self) // factory.instantiateLoginVC()
        vc.onBack = { [unowned self] in
            self.navigationController.popVC()
        }
        vc.onLogin = {
            self.finishFlow?()
        }
        vc.onSignUp = {
            self.showSignUpVC()
        }

        navigationController.pushViewController(vc, animated: true)
    }

    private func showSignUpVC() {
        let vc = container.resolveViewController(SignUpVC.self) // factory.instantiateSignUpVC()
        vc.onBack = { [unowned self] in
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.onSignUp = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.onSignIn = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        navigationController.present(vc, animated: true, completion: nil)
    }
}
