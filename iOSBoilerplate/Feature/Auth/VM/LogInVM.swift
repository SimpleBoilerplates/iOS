//
//  SignInVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON
class LogInVM: BaseVM {
    var signedIn: ((Bool, JSON?) -> Void)?

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
                        // let filteredResponse = try response.filterSuccessfulStatusCodes()

                        let json = try JSON(data: response.data)
                        if json.isSuccess {
                            AuthHelper.setAcessToken(token: json["token"].stringValue)
                            self.signedIn?(true, json)
                        } else {
                            self.signedIn?(false, nil)
                            self.alert = Alert(title: json.message, message: "")
                        }

                    } catch let error {
                        self.signedIn?(false, nil)
                        self.alert = Alert(
                            title: (error.localizedDescription),
                            message: ""
                        )
                    }
                } else {
                    self.signedIn?(false, nil)
                    self.alert = Alert(
                        title: (result.error?.errorDescription),
                        message: ""
                    )
                }
            })
        }
    }
}
