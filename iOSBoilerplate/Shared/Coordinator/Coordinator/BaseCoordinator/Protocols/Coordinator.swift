//
//  Coordinator.swift

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
