//
import Swinject
import UIKit

enum AppChildCoordinator {
    case auth
    case home
}

final class AppCoordinator: Coordinator {
    // MARK: - Properties

    private let window: UIWindow
    let container: Container

    private var launchInstructor: LaunchInstructor
    private var navigationController: UINavigationController
    private var childCoordinators = [AppChildCoordinator: Coordinator]()

     // MARK: - Init

      init(window: UIWindow, container: Container, navigationController: UINavigationController, launchInstructor: LaunchInstructor) {
          self.window = window
          self.container = container
          self.navigationController = navigationController
          self.launchInstructor = launchInstructor

          self.window.rootViewController = navigationController
      }
    
    // MARK: - Coordinator

    func start() {
        switch launchInstructor {
        case .auth: runAuthFlow()
        case .main: runHomeFlow()
        }
    }

    // MARK: - Private methods

    private func runAuthFlow() {
        let coordinator = AuthCoordinator(container: container, navigationController: navigationController)
        coordinator.finishFlow = { [unowned self] in
            self.childCoordinators[.auth] = nil
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.navigationController.viewControllers.removeAll()
            self.start()
        }
        childCoordinators[.auth] = coordinator
        coordinator.start()
    }

    private func runHomeFlow() {
        let coordinator = HomeCoordinator(container: container, navigationController: navigationController)
        coordinator.finishFlow = { [unowned self] in
            self.childCoordinators[.home] = nil
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.navigationController.viewControllers.removeAll()
            self.start()
        }
        childCoordinators[.home] = coordinator
        coordinator.start()
    }

 
}
