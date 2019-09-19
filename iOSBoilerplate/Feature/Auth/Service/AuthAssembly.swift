//
//  AuthAssembly.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/18/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import Moya
import Swinject

class AuthAssembly: Assembly {
    func assemble(container: Container) {
        //let userService = UserService()

        container.register(UserService.self, factory: { _ in
            UserService()
        }).inObjectScope(ObjectScope.container)

        container.register(MoyaProvider<AuthService>.self, factory: { _ in
            MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
        }).inObjectScope(ObjectScope.container)

        container.register(SignUpVM.self, factory: { container in
            SignUpVM(service: container.resolve(MoyaProvider<AuthService>.self)!)
        }).inObjectScope(ObjectScope.container)

        container.register(LogInVM.self, factory: { container in
            LogInVM(service: container.resolve(MoyaProvider<AuthService>.self)!, userService: container.resolve(UserService.self)!)
        }).inObjectScope(ObjectScope.container)
    }
}
