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

    var rootController: CoordinatorNavigationController {
        return window!.rootViewController as! CoordinatorNavigationController
    }

    var assembler: Assembler!

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        assembler = Assembler([
            AuthAssembly(),
            HomeAssembly()
        ], container: container)

        appCoordinator = AppCoordinator(window: window!, container: container, navigationController: rootController, launchInstructor: LaunchInstructor.configure(isAutorized: UserService.shared.isAuthonticated()))
        appCoordinator.start()
        return true
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // CHECK RESOURCE COUNT IN EVERY SECOND
//        _ = Observable<Int>
//            .interval(1, scheduler: MainScheduler.instance)
//            .subscribe(
//                onNext: { _ in
//                    //print("Resource count: \(RxSwift.Resources.total).")
//            }
//        )

        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}
}

extension AppDelegate {
    func getAssembler() -> Assembler {
        return assembler
    }
}
