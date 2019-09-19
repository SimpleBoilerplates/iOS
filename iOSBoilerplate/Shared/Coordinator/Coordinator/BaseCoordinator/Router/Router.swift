//
//  Router.swift

import UIKit

protocol RouterProtocol: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle)
    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?, animated: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)

    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)

    func showTitles()
    func hideTitles()
}

final class Router: NSObject, RouterProtocol {
    // MARK: - Vars & Lets

    private weak var rootController: CoordinatorNavigationController?
    private var completions: [UIViewController: () -> Void]

    // MARK: - Presentable

    func toPresent() -> UIViewController? {
        return rootController
    }

    // MARK: - RouterProtocol

    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle) {
        guard let controller = module?.toPresent() else {
            return
        }
        controller.modalPresentationStyle = modalPresentationSytle
        rootController?.present(controller, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController?.present(controller, animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        push(module, transition: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        push(module, transition: transition, animated: true)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        push(module, transition: transition, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        rootController?.setTransition(transition: transition)

        guard let controller = module?.toPresent(),
            controller is UINavigationController == false
        else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    func popModule() {
        popModule(transition: nil)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        popModule(transition: transition, animated: true)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        rootController?.setTransition(transition: transition)
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popToModule(module: Presentable?, animated: Bool = true) {
        if let controllers = self.rootController?.viewControllers, let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    rootController?.popToViewController(controller, animated: animated)
                    runCompletion(for: controller)
                    break
                }
            }
        }
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?, animated: Bool) {
        setRootModule(module, hideBar: false, animated: animated)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController?.setViewControllers([controller], animated: animated)
        rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }

    func showTitles() {
        rootController?.isNavigationBarHidden = false
        rootController?.navigationBar.prefersLargeTitles = true
        rootController?.navigationBar.tintColor = UIColor.black
    }

    func hideTitles() {
        rootController?.isNavigationBarHidden = true
    }

    // MARK: - Private methods

    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: - Init methods

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        completions = [:]
        super.init()
    }
}
