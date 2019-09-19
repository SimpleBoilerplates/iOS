//
//  ApplicationCoordinator.swift

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Vars & Lets

    private let factory: Factory
    private let router: RouterProtocol
    private var launchInstructor: LaunchInstructor

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
        let coordinator = factory.instantiateAuthCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func runHomeFlow() {
        let coordinator = factory.instantiateHomeCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated())
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    // MARK: - Init

    init(router: RouterProtocol, factory: Factory, launchInstructor: LaunchInstructor) {
        self.router = router
        self.factory = factory
        self.launchInstructor = launchInstructor
    }
}
