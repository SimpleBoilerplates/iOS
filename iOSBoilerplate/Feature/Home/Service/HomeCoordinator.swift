//
//  WalktroughCoordinator.swift


import Foundation

final class HomeCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets
    private let router: RouterProtocol
    private let factory: Factory

    // MARK: - Private metods

    private func showHomeVC() {
        let vc = self.factory.instantiateHomeVC()
        vc.onSignOut = {
            self.finishFlow?()
        }
        vc.onBookSelected = { viewModel in
            self.showBookDetailVC(viewModel: viewModel)
        }
        self.router.push(vc)
    }

    private func showBookDetailVC(viewModel: BookDetailVM) {
        let vc = self.factory.instantiateBookDetailVC(viewModel: viewModel)
        vc.onBack = { [unowned self] in
            self.router.popModule()
        }
        self.router.push(vc)
    }

    // MARK: - Coordinator
    override func start() {
        self.showHomeVC()
    }

    // MARK: - Init
    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }

}
