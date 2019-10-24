//
//  AuthCoordinator.swift

//

import Swinject
import UIKit

enum AuthChildCoordinator {
    case about
}

final class AuthCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    let navigationController: UINavigationController
    let container: Container
    private var childCoordinators = [AuthChildCoordinator: Coordinator]()

    // MARK: - Coordinator

    func start() {
        showLoginVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private methods

    private func showLoginVC() {
        let vc = container.resolveViewController(LoginVC.self)
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
        let vc = container.resolveViewController(SignUpVC.self) 
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
