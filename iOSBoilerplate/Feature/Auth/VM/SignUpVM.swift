//
//  SignUpVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON

class SignUpVM: BaseVM {
    var signedUp: ((Bool, JSON?) -> Void)?

    var alert: Alert? {
        didSet {
            showError?(alert!)
        }
    }

    func signUp(fullName: String?, email: String?, password: String?) {
        if let fullName = fullName, let email = email, let password = password {
            showLoadingHUD?(true)

            authProvider.request(.signUp(fullName, email, password), completion: { result in
                self.showLoadingHUD?(false)
                if case let .success(response) = result {
                    do {
                        // let filteredResponse = try response.filterSuccessfulStatusCodes()

                        let json = try JSON(data: response.data)
                        if !json.isError {
                            self.signedUp?(true, json)
                        } else {
                            self.signedUp?(false, nil)
                            self.alert = Alert(title: json.message, message: "")
                        }

                    } catch let error {
                        self.signedUp?(false, nil)
                        self.alert = Alert(
                            title: (error.localizedDescription),
                            message: ""
                        )
                    }
                } else {
                    self.signedUp?(false, nil)
                    self.alert = Alert(
                        title: (result.error?.errorDescription),
                        message: ""
                    )
                }
            })
        }
    }
}
