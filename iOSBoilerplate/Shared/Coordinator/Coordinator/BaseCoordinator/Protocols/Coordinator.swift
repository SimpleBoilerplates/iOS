//
//  Coordinator.swift

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}


protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
