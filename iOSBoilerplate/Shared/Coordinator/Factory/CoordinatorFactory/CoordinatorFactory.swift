//
//  CoordinatorFactory.swift
//  iOSStyleguide
//
//  Created by Pavle Pesic on 3/14/18.
//  Copyright © 2018 Fabrika. All rights reserved.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator() -> ApplicationCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator
    func instantiateHomeCoordinator(router: RouterProtocol) -> HomeCoordinator
}
