//
//  LaunchInstructor.swift
//  iOSStyleguide
//
//  Created by Pavle Pesic on 3/14/18.
//  Copyright © 2018 Fabrika. All rights reserved.
//

import Foundation

enum LaunchInstructor {
    
    case main
    case auth
    
    // MARK: - Public methods
    
    static func configure(isAutorized: Bool = false) -> LaunchInstructor {
        
        let isAutorized = isAutorized
        //let tutorialWasShown = tutorialWasShown
        
//        if AuthUserDefaultsServices.shared().getToken() != nil {
//            isAutorized = true
//            tutorialWasShown = true
//        }
        
        switch ( isAutorized) {
            case false: return .auth
            case true: return .main
        }
    }
}
