//
//  Print.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/9/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation

func printToConsole(message: String) {
    #if DEBUG
        print(message)
    #endif
}
