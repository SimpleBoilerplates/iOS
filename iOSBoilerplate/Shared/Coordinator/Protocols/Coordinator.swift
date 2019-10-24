//
//  Coordinator.swift

import Swinject
import UIKit

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}

protocol Coordinator: AnyObject {
    /**
     DI container
     */
    var container: Container { get }

    /**
     Entry point starting the coordinator
     */
    func start()
}

protocol NavigationCoordinator: Coordinator {
    /**
     Navigation controller
     */
    var navigationController: UINavigationController { get }
}
