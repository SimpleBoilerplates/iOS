//
//  LaunchInstructor.swift

import Foundation

enum LaunchInstructor {
    case main
    case auth

    // MARK: - Public methods

    static func configure(isAutorized: Bool = false) -> LaunchInstructor {
        let isAutorized = isAutorized

        switch isAutorized {
        case false: return .auth
        case true: return .main
        }
    }
}
