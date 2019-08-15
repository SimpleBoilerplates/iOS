//
//  SignInVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxRelay
import Moya
struct LogInVM  {
   
    
    let authProvider = MoyaProvider<Auth>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

    
    private let isLoadingVariable = BehaviorRelay(value: false)
    private let alertMessageVariable = PublishSubject<AlertMessage>()

    var onShowingLoading: Observable<Bool> {
        return self.isLoadingVariable.asObservable()
            .distinctUntilChanged()
    }
    var onShowAlert: Observable<AlertMessage> {
        return self.alertMessageVariable.asObservable()
    }
    
    
    
    private let successVariable = PublishSubject<JSON>()

    var onSuccess: Observable<JSON> {
        return self.successVariable.asObservable()
    }
    
    //var success = BehaviorRelay<JSON?>(value: nil)
  //  var alertMessage = BehaviorRelay<AlertMessage?>(value: nil)

    var email = BehaviorRelay<String?>(value: nil)
    var password = BehaviorRelay<String?>(value: nil)
    
    var isValid : Observable<Bool>{
        return Observable.combineLatest( self.email, self.password)
        { (email, password) in
            
        guard let email = email, let password = password else{
                return false
            }
            
            return email.count > 0
                && password.count > 0
        }.share()
    }
    
    func login() {
        if let email = email.value, let password = password.value {
            isLoadingVariable.accept(true)
           // showLoadingHUD?(true)

            authProvider.request(.login(email, password), completion: { result in
                //self.showLoadingHUD?(false)
                self.isLoadingVariable.accept(false)

                if case let .success(response) = result {
                    do {
                        // let filteredResponse = try response.filterSuccessfulStatusCodes()

                        let json = try JSON(data: response.data)
                        //dump(json)
                        if !json.isError {
                            AuthHelper.setAcessToken(token: json["token"].stringValue)
                            //self.success.accept(json)
                            self.successVariable.onNext(json)
                            //self.signedIn?(true, json)
                        } else {
                            //self.alertMessage.accept(AlertMessage(title: json.message, message: ""))
                            self.alertMessageVariable.onNext(AlertMessage(title: json.message, message: ""))
                           // self.signedIn?(false, nil)
                           // alert = Alert(title: json.message, message: "")
                        }

                    } catch let error {
                        //self.signedIn?(false, nil)
                        //self.alertMessage.accept(AlertMessage(title: error.localizedDescription, message: ""))
                       self.alertMessageVariable.onNext(AlertMessage(title: (error.localizedDescription), message: "" ))
//                        alert = Alert(
//                            title: (error.localizedDescription),
//                            message: ""
//                        )
                    }
                } else {
                   // self.alertMessage.accept(AlertMessage(title: result.error?.errorDescription, message: ""))
                    self.alertMessageVariable.onNext(AlertMessage(title: result.error?.errorDescription, message: "" ))
                   // self.signedIn?(false, nil)
//                    alert = Alert(
//                        title: (result.error?.errorDescription),
//                        message: ""
//                    )
                }
            })
        }
    }
}
