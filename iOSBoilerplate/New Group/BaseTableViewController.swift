//
//  BaseTableViewController.swift
//  Hero
//
//  Created by sadman samee on 6/5/17.
//  Copyright © 2017 sadman samee. All rights reserved.
//

import Reachability
import UIKit

class BaseTableViewController: UITableViewController {
    var isConnectedToInternet: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // NotificationCenter.default.addObserver(self, selector: #selector(self.internetStatusChangedNotification(_:)), name: Reachability.internetStatusChangedNotification, object: nil)

//        if Reachability.isReachable
//        {
//            isConnectedToInternet = true
//
//        }else
//        {
//            isConnectedToInternet = false
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    func internetStatusChangedNotification(_ notification: NSNotification)  {
//
//        if Reachability.isReachable
//        {
//            isConnectedToInternet = true
//            //AppHUD.showErrorMessage("", title: KString.Message.connectedToInternet)
//        }else
//        {
//            isConnectedToInternet = false
//            //AppHUD.showErrorMessage("", title: KString.Message.notConnectedToInternet)
//        }
//    }
}

extension BaseTableViewController {
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyBoardValueBegin = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let keyBoardValueEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, keyBoardValueBegin != keyBoardValueEnd else {
            return
        }

        let keyboardHeight = keyBoardValueEnd.height

        tableView.contentInset.bottom = keyboardHeight
    }
}
