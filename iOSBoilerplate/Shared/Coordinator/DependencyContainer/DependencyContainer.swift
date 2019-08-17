//
//  DependencyContainer.swift


import UIKit
import Alamofire

typealias Factory = CoordinatorFactoryProtocol & ViewControllerFactory
typealias ViewControllerFactory = AuthFactory & HomeFactory

class DependencyContainer {

    // MARK: - Vars & Lets

    private var rootController: CoordinatorNavigationController

    // MARK: App Coordinator

    internal lazy var aplicationCoordinator = self.instantiateApplicationCoordinator()

    // MARK: APi Manager

//    internal lazy var sessionManager = SessionManager()
//    internal lazy var retrier = APIManagerRetrier()
//    internal lazy var apiManager = APIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//
//    // MARK: Network services
//
//    internal lazy var authNetworkServices = AuthNetworkServices(apiManager: self.apiManager)
//
//    // MARK: Cache services
//
//    internal lazy var userServices = UserServices()
//
    // MARK: - Public func

    func start() {
        self.aplicationCoordinator.start()
    }

    // MARK: - Initialization

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        self.customoizeNavigationController()
    }

    // MARK: - Private methods

    private func customoizeNavigationController() {
        self.rootController.enableSwipeBack()
        self.rootController.customizeTitle(titleColor: UIColor.red,
                largeTextFont: UIFont(name: "Menlo-Bold", size: 18)!,
                smallTextFont: UIFont(name: "Menlo-Bold", size: 12)!,
                isTranslucent: true,
                barTintColor: nil)
        self.rootController.customizeBackButton(backButtonImage: UIImage(named: "GoBack"),
                backButtonTitle: "",
                backButtonfont: UIFont(name: "Menlo-Bold", size: 15),
                backButtonTitleColor: .black,
                shouldUseViewControllerTitles: false)
    }

}

// MARK: - Extensions
// MARK: - CoordinatorFactoryProtocol

extension DependencyContainer: CoordinatorFactoryProtocol {

    func instantiateApplicationCoordinator() -> ApplicationCoordinator {
        return ApplicationCoordinator(router: Router(rootController: rootController), factory: self as Factory, launchInstructor: LaunchInstructor.configure(isAutorized: AppSingleton.shared.isAuthonticated()))
    }

    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator {
        return AuthCoordinator(router: router, factory: self)
    }

    func instantiateHomeCoordinator(router: RouterProtocol) -> HomeCoordinator {
        return HomeCoordinator(router: router, factory: self)
    }

}
