//
//  BaseTableViewController.swift
//  Hero
//
//  Created by sadman samee on 6/5/17.
//  Copyright © 2017 sadman samee. All rights reserved.
//

import Reachability
import UIKit

class BaseTableViewController: UITableViewController, CoordinatorNavigationControllerDelegate {
    var isConnectedToInternet: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Controller lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
    }

    // MARK: - Private methods

    private func setupNavigationController() {
        if let navigationController = self.navigationController as? CoordinatorNavigationController {
            navigationController.swipeBackDelegate = self
        }
    }

    // MARK: - SwipeBackNavigationControllerDelegate

    internal func transitionBackFinished() {}

    internal func didSelectCustomBackAction() {}
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
