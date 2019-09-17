//
//  AppDelegate.swift
//  ExtraaNumber
//
//  Created by sadman samee on 13/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit
import Swinject
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var container = Container() {
        container in
        
        
        
        container.register(MoyaProvider<AuthService>.self, factory: { (container) in
           MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
        }).inObjectScope(ObjectScope.container)
        
        let userService = UserService()
        
        let tokenClosure: () -> String = {
            userService.getAcessToken()
        }
        
        container.register(UserService.self, factory: { (container) in
            userService
        }).inObjectScope(ObjectScope.container)
        
        container.register(MoyaProvider<BooksService>.self, factory: { (container) in
            MoyaProvider<BooksService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter), AccessTokenPlugin(tokenClosure: tokenClosure)])
        }).inObjectScope(ObjectScope.container)
        
        container.register(HomeVM.self, factory: { (container) in
            HomeVM(service: container.resolve(MoyaProvider<BooksService>.self)!)
        }).inObjectScope(ObjectScope.container)

        container.register(SignUpVM.self, factory: { (container) in
            SignUpVM(service: container.resolve(MoyaProvider<AuthService>.self)!)
        }).inObjectScope(ObjectScope.container)
        
        container.register(LogInVM.self, factory: { (container) in
            LogInVM(service: container.resolve(MoyaProvider<AuthService>.self)!, userService: userService)
        }).inObjectScope(ObjectScope.container)
    }
    
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

extension AppDelegate {
    func getContainer() -> Container {
        return container
    }
}

