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

class HomeAssembly: Assembly{
    func assemble(container: Container) {
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
    }
}
