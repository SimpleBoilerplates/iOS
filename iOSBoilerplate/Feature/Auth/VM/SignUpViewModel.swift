//
//  SignUpVM.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya
import RxRelay
import RxSwift
import SwiftyJSON

final class SignUpViewModel {
    
    private var authProvider: MoyaProvider<AuthService>
    private let disposeBag = DisposeBag()

    init(service: MoyaProvider<AuthService>) {
        authProvider = service
        
        signButtonTapped.asObserver()
               .subscribe(onNext: { [weak self] in

                   guard let self = self else {
                       return
                   }

                   self.signUp()
               }).disposed(by: disposeBag)
    }

    private let isLoading = BehaviorRelay(value: false)
    private let alertMessage = PublishSubject<AlertMessage>()
    private let isSuccess = PublishSubject<JSON>()

    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var fullName = BehaviorRelay<String>(value: "")

    let signButtonTapped = PublishSubject<Void>()

    var onShowingLoading: Observable<Bool> {
        return isLoading.asObservable()
            .distinctUntilChanged()
    }

    var onShowAlert: Observable<AlertMessage> {
        return alertMessage.asObservable()
    }

    var onSuccess: Observable<JSON> {
        return isSuccess.asObservable()
    }

    var isValidAll: Observable<Bool> {
        return Observable.combineLatest(email, password) { email, password in
            return (email.count >= 6 && email.isvalidEmail)
                && password.count >= 6
        }.share().distinctUntilChanged()
    }
    
    

    func signUp() {
        isLoading.accept(true)

        authProvider.request(.signUp(fullName.value, email.value, password.value), completion: { result in
                self.isLoading.accept(false)
            
                if case let .success(response) = result {
                    do {
                        let json = try JSON(data: response.data)
                        if !json.isError {
                            self.isSuccess.onNext(json)
                        } else {
                            self.alertMessage.onNext(AlertMessage(title: json.message, message: ""))
                        }
                    } catch {
                        self.alertMessage.onNext(AlertMessage(title: error.localizedDescription, message: ""))
                    }
                } else {
                    self.alertMessage.onNext(AlertMessage(title: result.error?.errorDescription, message: ""))
                }
            })
    }
}
