//
//  Extension+ViewController.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit

extension UIViewController {
    open func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

    open func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    open func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
}
