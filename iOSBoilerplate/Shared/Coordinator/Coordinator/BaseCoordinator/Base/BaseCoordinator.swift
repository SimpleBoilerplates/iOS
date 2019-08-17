//
//  BaseCoordinator.swift
//  iOSStyleguide
//
//  Created by Pavle Pesic on 3/14/18.
//  Copyright © 2018 Fabrika. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    // MARK: - Vars & Lets
    
    var childCoordinators = [Coordinator]()
    
    // MARK: - Public methods
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    // MARK: - Coordinator
    
    func start() {
        start(with: nil)
    }
    
    func start(with option: DeepLinkOption?) {
        
    }
    
}
