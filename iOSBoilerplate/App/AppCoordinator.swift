//
import Swinject
//  ApplicationCoordinator.swift
import UIKit

final class AppCoordinator: BaseCoordinator {
    // MARK: - Properties

    private let window: UIWindow
    let container: Container
    // private let factory: Factory
    // private let router: RouterProtocol
    private var launchInstructor: LaunchInstructor
    private var navigationController: CoordinatorNavigationController

    // MARK: - Coordinator

    override func start(with option: DeepLinkOption?) {
        if option != nil {
        } else {
            switch launchInstructor {
            case .auth: runAuthFlow()
            case .main: runHomeFlow()
            }
        }
    }

    // MARK: - Private methods

    private func runAuthFlow() {
        let coordinator = AuthCoordinator(container: container, navigationController: navigationController) // factory.instantiateAuthCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func runHomeFlow() {
        let coordinator = HomeCoordinator(container: container, navigationController: navigationController) // factory.instantiateHomeCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    // MARK: - Init

    init(window: UIWindow, container: Container, navigationController: CoordinatorNavigationController, launchInstructor: LaunchInstructor) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
        self.launchInstructor = launchInstructor

        self.window.rootViewController = navigationController
    }

//    init(router: RouterProtocol, factory: Factory, launchInstructor: LaunchInstructor) {
//        self.router = router
//        self.factory = factory
//        self.launchInstructor = launchInstructor
//    }
}
