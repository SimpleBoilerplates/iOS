//
//  AppCoordinator.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/15/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation

import UIKit

final class AppCoordinator: Coordinator {
    func start() {
        if AuthHelper.Auth().isLoggedIn {
            let child = HomeCoordinator(navigationController: navigationController, appCoordinator: self)
            childCoordinators.append(child)
            child.start()
        } else {
            let child = AuthCoordinator(navigationController: navigationController, appCoordinator: self)
            childCoordinators.append(child)
            child.start()
        }
    }

    func homeCoordinatorCompleted(coordinator: HomeCoordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) { // .index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
        start()
    }

    func authCoordinatorCompleted(coordinator: AuthCoordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
        start()
    }
}
