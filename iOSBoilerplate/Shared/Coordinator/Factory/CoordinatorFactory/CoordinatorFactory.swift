//
//  CoordinatorFactory.swift


import UIKit

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator() -> ApplicationCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator
    func instantiateHomeCoordinator(router: RouterProtocol) -> HomeCoordinator
}
