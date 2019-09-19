//
//  DependencyContainer.swift

import Alamofire
import UIKit

typealias Factory = CoordinatorFactoryProtocol & ViewControllerFactory
typealias ViewControllerFactory = AuthFactory & HomeFactory

class CoordinatorContainer {
    // MARK: - Vars & Lets

    private var rootController: CoordinatorNavigationController

    // MARK: App Coordinator

    internal lazy var aplicationCoordinator = self.instantiateApplicationCoordinator()

    // MARK: - Public func

    func start() {
        aplicationCoordinator.start()
    }

    // MARK: - Initialization

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        customoizeNavigationController()
    }

    // MARK: - Private methods

    private func customoizeNavigationController() {
        rootController.enableSwipeBack()
//        self.rootController.customizeTitle(titleColor: UIColor.red,
//                largeTextFont: UIFont(name: "Menlo-Bold", size: 18)!,
//                smallTextFont: UIFont(name: "Menlo-Bold", size: 12)!,
//                isTranslucent: true,
//                barTintColor: nil,
//                prefersLargeTitles: false)
        rootController.customizeBackButton(backButtonImage: UIImage(named: "GoBack"),
                                           backButtonTitle: "",
                                           backButtonfont: UIFont(name: "Menlo-Bold", size: 15),
                                           backButtonTitleColor: .black,
                                           shouldUseViewControllerTitles: false)
    }
}

// MARK: - Extensions

// MARK: - CoordinatorFactoryProtocol

extension CoordinatorContainer: CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator() -> ApplicationCoordinator {
        return ApplicationCoordinator(router: Router(rootController: rootController), factory: self as Factory, launchInstructor: LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated()))
    }

    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator {
        return AuthCoordinator(router: router, factory: self)
    }

    func instantiateHomeCoordinator(router: RouterProtocol) -> HomeCoordinator {
        return HomeCoordinator(router: router, factory: self)
    }
}
