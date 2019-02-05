//
//  SignInVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation

class LogInVM: BaseVM {
    var signedIn: ((Bool, Dictionary<String, Any>?) -> Void)?

    var alert: Alert? {
        didSet {
            showError?(alert!)
        }
    }

    func login(email: String?, password: String?) {
        if let email = email, let password = password {
            showLoadingHUD?(true)

            authProvider.request(.login(email, password), completion: { result in
                self.showLoadingHUD?(false)
                if case let .success(response) = result {
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        // let decoder = JSONDecoder()
                        // decoder.keyDecodingStrategy = .convertFromSnakeCase
                        // let user  =  try! response.map(User.self,atKeyPath: "data",using: decoder)

                        let json = try filteredResponse.mapJSON()
                        if let dictionary = json as? [String: Any] {
                            // dictionary[""]
                        }
//                        if let json = try? JSON(data: filteredResponse.data) {
//                            self.signedIn?(true, json)
//                        } else {
//                            self.signedIn?(false, nil)
//                        }
                    } catch let error {
                        // Here we get either statusCode error or jsonMapping error.
                        self.signedIn?(false, nil)
                        self.alert = Alert(
                            title: (error.localizedDescription),
                            message: ""
                        )
                    }
                } else {
                    self.signedIn?(false, nil)
                    // self.alert = Alert(
                    // title: (error.localizedDescription),
                    //    message: ""
                    //   )
                }
            })
        }
    }
}
