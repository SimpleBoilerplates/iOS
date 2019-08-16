//
//  BaseViewController.swift
//  Hero
//
//  Created by sadman samee on 6/5/17.
//  Copyright © 2017 sadman samee. All rights reserved.
//

import Reachability
import UIKit

class BaseViewController: UIViewController {
    var isConnectedToInternet: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

//        NotificationCenter.default.addObserver(self, selector: #selector(self.internetStatusChangedNotification(_:)), name: Reachability.internetStatusChangedNotification, object: nil)
//
//        if Reachability.isReachable
//        {
//            isConnectedToInternet = true
//
//        }else
//        {
//            isConnectedToInternet = false
//            //AppHUD.showErrorMessage("", title: KString.Message.notConnectedToInternet)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
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

extension BaseViewController: NetworkStatusListener {
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            print("ViewController: Network became unreachable")
        case .wifi:
            print("ViewController: Network reachable through WiFi")
        case .cellular:
            print("ViewController: Network reachable through Cellular Data")
        }
        // loginButton.isEnabled = !(status == .notReachable)
    }
}
