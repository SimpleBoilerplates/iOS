//
//  HomeVM.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya
import RxRelay
import RxSwift
import SwiftyJSON

enum BookTableViewCellType {
    case normal(cellViewModel: BookViewModel)
}

protocol HomeVMType {
    var onShowingLoading: Observable<Bool> { get }
    var onShowAlert: Observable<AlertMessage> { get }
    var bookCells: Observable<[BookTableViewCellType]> { get }
}

class HomeViewModel {
    var booksProvider: MoyaProvider<BooksService>
    var userService: UserService!
    let disposeBag = DisposeBag()

    init(service: MoyaProvider<BooksService>, userService: UserService) {
        booksProvider = service
        self.userService = userService

        logoutTapped.asObserver()
            .subscribe(onNext: { [weak self] in

                guard let self = self else {
                    return
                }
                userService.logout()
                self.isLogout.onNext(true)
            }).disposed(by: disposeBag)
    }

    var onShowingLoading: Observable<Bool> {
        return isLoading.asObservable()
            .distinctUntilChanged()
    }

    var onShowAlert: Observable<AlertMessage> {
        return alertMessage.asObservable()
    }

    var onLogout: Observable<Bool> {
        return isLogout.asObservable().distinctUntilChanged()
    }

    var onBookCells: Observable<[BookTableViewCellType]> {
        return bookCells.asObservable()
    }

    private let isLogout = PublishSubject<Bool>()
    private let isLoading = BehaviorRelay(value: false)
    private let alertMessage = PublishSubject<AlertMessage>()
    private let bookCells = BehaviorRelay<[BookTableViewCellType]>(value: [])

    let logoutTapped = PublishSubject<Void>()

    func getBooks() {
        isLoading.accept(true)
        booksProvider.request(.books, completion: { result in
            self.isLoading.accept(false)

            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()

                    let json = JSON(filteredResponse.data)

                    if !json.isError {
                        let items = json["data"].arrayValue.compactMap {
                            BookTableViewCellType.normal(cellViewModel: Book(fromJson: $0))
                        }

                        self.bookCells.accept(items)
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
