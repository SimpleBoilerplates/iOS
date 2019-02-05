//
//  AuthHelper.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
class AuthHelper {
    class func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }

    class func getAcessToken() -> String {
        var token = ""
        if let tok = UserDefaults.standard.value(forKey: "token"), let tokenString = tok as? String {
            token = tokenString
        }
        return token
    }

    class func saveUser(user: User) {
        UserDefaults.standard.set(user.toDictionary(), forKey: "user")
        setUser()
    }

    class func setUser() -> Bool {
        if let usr = UserDefaults.standard.value(forKey: "user") {
            let usrDictionary = usr as! Dictionary<String, Any>
            let json = JSON(parseJSON: usrDictionary.json)
            user = User(fromJson: json)
            return true
        } else {
            return false
        }
    }

    class func getAccessToken() -> (isLoggedIn: Bool, accessToken: String) {
        return (isLoggedIn: isLoggedIn(), accessToken: user.accessToken)
    }

    class func isLoggedIn() -> Bool {
        if user != nil {
            return true
        } else {
            return false
        }
    }

    class func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        defaults.synchronize()
    }
}
