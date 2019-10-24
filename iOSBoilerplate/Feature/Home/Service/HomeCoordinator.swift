//
//  WalktroughCoordinator.swift

import Foundation
import Swinject

enum HomeChildCoordinator {
    case about
}

final class HomeCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?
    let container: Container

    // MARK: - Vars & Lets

    let navigationController: UINavigationController
    private var childCoordinators = [HomeChildCoordinator: Coordinator]()

    // MARK: - Coordinator

    func start() {
        showHomeVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: UINavigationController) {
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

    private func showBookDetailVC(viewModel: BookDetailVM) {
        let vc = container.resolveViewController(BookDetailVC.self)
        vc.viewModel = viewModel

        vc.onBack = { [unowned self] in
            self.navigationController.popVC()
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
