//
//  SwiftSugarClosure.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/15/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation

@discardableResult
func with<T: AnyObject>(_ obj: T, task: (T)->Void) -> T {
    task(obj)
    return obj
}

@discardableResult
func with<T: AnyObject>(maybe obj: T?, task: (T)->Void) -> T? {
    if let obj = obj { task(obj) }
    return obj
}

@discardableResult
func with<T: Any>(value: T, task: (inout T)->Void) -> T {
    var newValue = value
    task(&newValue)
    return newValue
}
