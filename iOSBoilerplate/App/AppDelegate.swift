//
//  AppDelegate.swift
//  ExtraaNumber
//
//  Created by sadman samee on 13/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya
import Swinject
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal let container = Container()

    private var appCoordinator: AppCoordinator!

    var assembler: Assembler!

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        assembler = Assembler([
            AuthAssembly(),
            HomeAssembly()
        ], container: container)

        return true
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        appCoordinator = AppCoordinator(window: window!, container: container, navigationController: UINavigationController(), launchInstructor: LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated()))

        appCoordinator.start()
        window?.makeKeyAndVisible()

        return true
    }
}
