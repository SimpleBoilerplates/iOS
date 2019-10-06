//
//  AppSingleton.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/17/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON

final class UserService {
    static let shared: UserService = {
        let instance = UserService()
        // Setup code
        return instance
    }()

    init() {
        user = fetchUser()
    }

    private var user: User?

    func isAuthonticated() -> Bool {
        if let tok = UserDefaults.standard.value(forKey: "token"), let tokenString = tok as? String {
            return true
        } else {
            return false
        }
    }

    func getAcessToken() -> String {
        if let tok = UserDefaults.standard.value(forKey: "token"), let tokenString = tok as? String {
            return tokenString
        } else {
            return ""
        }
    }

    func setAcessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }

    func fetchUser() -> User? {
        var user: User?
        if let usr = UserDefaults.standard.value(forKey: "user") {
            let usrDictionary = usr as! [String: Any]
            let json = JSON(parseJSON: usrDictionary.json)
            user = User(fromJson: json)
        }
        return user
    }

    func saveUser(user: User) {
        UserDefaults.standard.set(user.toDictionary(), forKey: "user")
        self.user = user
    }

    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
        user = nil
    }
}
