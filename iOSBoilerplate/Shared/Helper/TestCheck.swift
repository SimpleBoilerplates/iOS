//
//  TestCheck.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 10/6/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation

var isRunningTests: Bool {
    return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
