//
//  SignInVM.swift
//
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya
import RxRelay
import RxSwift
import SwiftyJSON

final class LogInViewModel {
    init(service: MoyaProvider<AuthService>, userService: UserService) {
        authProvider = service
        self.userService = userService

        loginButtonTapped.asObserver()
            .subscribe(onNext: { [weak self] in

                guard let self = self else {
                    return
                }

                self.login()
            }).disposed(by: disposeBag)
    }

    private var authProvider: MoyaProvider<AuthService>
    private var userService: UserService
    private let disposeBag = DisposeBag()

    private let isLoading = BehaviorRelay(value: false)
    private let alertMessage = PublishSubject<AlertMessage>()
    private let isSuccess = PublishSubject<JSON>()

    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")

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

    private var isPasswordValid: Observable<Bool> {
        return password.asObservable().map { $0.count >= 6 }
    }

    private var isEmailValid: Observable<Bool> {
        return email.asObservable().map { $0.count >= 6 && $0.isvalidEmail }
    }

    let loginButtonTapped = PublishSubject<Void>()

    var isValidAll: Observable<Bool> {
        return Observable.combineLatest(isPasswordValid,
                                        isEmailValid) { $0 && $1 }.distinctUntilChanged()
    }

    func login() {
        isLoading.accept(true)

        authProvider.request(.login(email.value, password.value), completion: { result in
            self.isLoading.accept(false)

            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
                    if !json.isError {
                        self.userService.save(token: json["token"].stringValue)
                        self.isSuccess.onNext(json)
                    } else {
                        self.alertMessage.onNext(AlertMessage(title: json.message, message: ""))
                    }
                } catch {
                    self.alertMessage.onNext(AlertMessage(title: error.localizedDescription, message: ""))
                }
            case let .failure(error):
                self.alertMessage.onNext(AlertMessage(title: error.errorDescription, message: ""))
            }

        })
    }
}
