
//
//  Extension+DI.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/16/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//
import Foundation
import UIKit
import Swinject

extension UIViewController {
    
    func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var container : Container {
        return (UIApplication.shared.delegate as! AppDelegate).getContainer()
    }
}
