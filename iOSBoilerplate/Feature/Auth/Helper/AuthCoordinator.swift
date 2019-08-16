//
//  AuthCoordinator.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/15/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func signIn()
    func signUp()
    func stop()
}

class AuthCoordinator: Coordinator {
    var appCoordinator: AppCoordinator?

    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
    }

    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?) {
        self.init(navigationController: navigationController)
        self.appCoordinator = appCoordinator
    }

    func start() {
        let vc = UIStoryboard.storyboard(storyboard: .Auth).instantiateViewController(LoginVC.self)
        vc.authCoordinatorDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func stop() {
        _ = navigationController?.popViewController(animated: true)
        appCoordinator?.authCoordinatorCompleted(coordinator: self)
    }

    func signUp() {
        let vc = UIStoryboard.storyboard(storyboard: .Auth).instantiateViewController(SignUpVC.self)
        vc.authCoordinatorDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AuthCoordinator: AuthCoordinatorDelegate {
    func signIn() {
        start()
    }
}
