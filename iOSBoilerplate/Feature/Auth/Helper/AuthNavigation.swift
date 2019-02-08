//
//  AuthNavigation.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit
extension UIViewController {
    func goToRoot() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootVc()
    }

    func goToLoginVC() {
        let vc = UIStoryboard.storyboard(storyboard: .Auth).instantiateViewController(LoginVC.self)
        presentVC(vc)
    }
}
