//
//  Extension+DI.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/16/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//
import Foundation
import Swinject
import UIKit

extension UIViewController {
    func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

//    var assembler: Assembler {
//        return (UIApplication.shared.delegate as! AppDelegate).getAssembler()
//    }
}
