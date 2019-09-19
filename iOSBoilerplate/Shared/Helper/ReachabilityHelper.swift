//
//  Reachability.swift
//  Ionic
//
//

import Reachability
import SystemConfiguration

// MARK: - using Reachiblity

public protocol NetworkStatusListener: AnyObject {
    func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager() // 2. Shared instance

    // 3. Boolean to track network reachability
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .none
    }

    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .none
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!

    // 6. Array of delegates which are interested to listen to network status change
    var listeners = [NetworkStatusListener]()

    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .none:

            break
        // debugPrint(“Network became unreachable”)
        case .wifi: break
        // debugPrint(“Network reachable through WiFi”)
        case .cellular: break
            // debugPrint(“Network reachable through Cellular Data”)
        }

        // Sending message to each of the delegates
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }

    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            //  debugPrint(“Could not start reachability notifier”)
        }
    }

    /// Stops monitoring the network availability status
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }

    /// Adds a new listener to the listeners array
    ///
    /// - parameter delegate: a new listener
    func addListener(listener: NetworkStatusListener) {
        listeners.append(listener)
    }

    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener) {
        listeners = listeners.filter {
            $0 !== listener
        }
    }
}
