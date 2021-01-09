//
//  HomeAssembly.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/18/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import Moya
import Swinject
import SwinjectAutoregistration

final class HomeAssembly: Assembly {
    func assemble(container: Container) {
        let userService = UserService()

        let authPlugin = AccessTokenPlugin { _ in userService.loadToken() ?? "" }

        container.register(UserService.self, factory: { _ in
            userService
        }).inObjectScope(ObjectScope.container)

        container.register(MoyaProvider<BooksService>.self, factory: { _ in
            MoyaProvider<BooksService>(plugins: [authPlugin, NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                                          logOptions: .verbose))])
        }).inObjectScope(ObjectScope.container)

        container.register(HomeViewModel.self, factory: { container in
            HomeViewModel(service: container.resolve(MoyaProvider<BooksService>.self)!, userService: userService)
        }).inObjectScope(ObjectScope.container)

        // view controllers
        container.storyboardInitCompleted(HomeVC.self) { r, c in
            c.homeViewModel = r.resolve(HomeViewModel.self)
        }
        container.storyboardInitCompleted(BookDetailVC.self) { _, _ in
        }
    }
}
