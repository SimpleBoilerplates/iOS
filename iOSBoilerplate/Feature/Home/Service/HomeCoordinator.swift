//
//  WalktroughCoordinator.swift

import Foundation
import Swinject
final class HomeCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    let navigationController: CoordinatorNavigationController
    let container: Container
    // private var childCoordinators = [AuthChildCoordinator: Coordinator]()

    // MARK: - Coordinator

    override func start() {
        showHomeVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: CoordinatorNavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private metods

    private func showHomeVC() {
        let vc = container.resolveViewController(HomeVC.self)
        vc.onSignOut = {
            self.finishFlow?()
        }
        vc.onBookSelected = { viewModel in
            self.showBookDetailVC(viewModel: viewModel)
        }
        navigationController.pushViewController(vc, animated: true)
    }

    private func showBookDetailVC(viewModel _: BookDetailVM) {
//        vc.onBack = { [unowned self] in
//        }
    }
}
