//
//  SignUpVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxRelay
import RxSwift
import Moya

class SignUpVM {
//    var signedUp: ((Bool, JSON?) -> Void)?
//
//    var alert: AlertMessage? {
//        didSet {
//            showError?(alert!)
//        }
//    }
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
    var fullName = BehaviorRelay<String?>(value: nil)

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
    
    
    func signUp() {
        if let fullName = fullName.value, let email = email.value, let password = password.value {
            isLoadingVariable.accept(true)

            authProvider.request(.signUp(fullName, email, password), completion: { result in
                self.isLoadingVariable.accept(false)
                if case let .success(response) = result {
                    do {
                        // let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let json = try JSON(data: response.data)
                        if !json.isError {
                            self.successVariable.onNext(json)
                            //self.signedUp?(true, json)
                        } else {
                            self.alertMessageVariable.onNext(AlertMessage(title: json.message, message: ""))
                           // self.signedUp?(false, nil)
                           // self.alert = AlertMessage(title: json.message, message: "")
                        }
                    } catch let error {
                        self.alertMessageVariable.onNext(AlertMessage(title: (error.localizedDescription), message: "" ))
                        //self.signedUp?(false, nil)
//                        self.alert = AlertMessage(
//                            title: (error.localizedDescription),
//                            message: ""
//                        )
                    }
                } else {
                    self.alertMessageVariable.onNext(AlertMessage(title: result.error?.errorDescription, message: "" ))
                    //self.signedUp?(false, nil)
//                    self.alert = AlertMessage(
//                        title: (result.error?.errorDescription),
//                        message: ""
//                    )
                }
            })
        }
    }
}
