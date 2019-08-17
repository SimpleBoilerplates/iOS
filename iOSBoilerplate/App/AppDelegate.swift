//
//  AppDelegate.swift
//  ExtraaNumber
//
//  Created by sadman samee on 13/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var rootController: CoordinatorNavigationController {
        return self.window!.rootViewController as! CoordinatorNavigationController
    }
    private lazy var dependencyConatiner = DependencyContainer(rootController: self.rootController)


    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.dependencyConatiner.start()

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

    func applicationWillResignActive(_: UIApplication) {
   
    }

    func applicationDidEnterBackground(_: UIApplication) {
    }

    func applicationWillEnterForeground(_: UIApplication) {
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }

}
