//
//  AppSingleton.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/17/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppSingleton {
    
    static let shared: AppSingleton = {
        let instance = AppSingleton()
        // Setup code
        return instance
    }()
    
    private init() {}
    
    private var user: User!

    func isAuthonticated() -> Bool{
        if let tok = UserDefaults.standard.value(forKey: "token"), let tokenString = tok as? String {
            return  true
        } else {
            return  false
        }
    }
    
    func getAcessToken() -> String{
        if let tok = UserDefaults.standard.value(forKey: "token"), let tokenString = tok as? String {
            return  tokenString
        } else {
            return  ""
        }
    }
    
    func setAcessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func fetchUser() -> User{
                if let usr = UserDefaults.standard.value(forKey: "user") {
                    let usrDictionary = usr as! Dictionary<String, Any>
                    let json = JSON(parseJSON: usrDictionary.json)
                    user = User(fromJson: json)
        }
        return user
    }
    
    func saveUser(user: User) {
        UserDefaults.standard.set(user.toDictionary(), forKey: "user")
    }
    
     func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }
    
}
