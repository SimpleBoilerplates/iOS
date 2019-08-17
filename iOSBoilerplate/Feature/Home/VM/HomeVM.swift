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
    case normal(cellViewModel: BookVM)
}

protocol HomeVMType {
    var onShowingLoading: Observable<Bool> { get }
    var onShowAlert: Observable<AlertMessage> { get }
    var bookCells: Observable<[BookTableViewCellType]> { get }
}

class HomeVM {
    let booksProvider: MoyaProvider<Books>

    init() {
        let tokenClosure: () -> String = {
            UserSingleton.shared.getAcessToken()
        }
        booksProvider = MoyaProvider<Books>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter), AccessTokenPlugin(tokenClosure: tokenClosure)])
    }

    var onShowingLoading: Observable<Bool> {
        return isLoadingVariable.asObservable()
                .distinctUntilChanged()
    }

    var onShowAlert: Observable<AlertMessage> {
        return alertMessageVariable.asObservable()
    }

    var bookCells: Observable<[BookTableViewCellType]> {
        return cells.asObservable()
    }

    private let isLoadingVariable = BehaviorRelay(value: false)
    private let alertMessageVariable = PublishSubject<AlertMessage>()
    private let cells = BehaviorRelay<[BookTableViewCellType]>(value: [])

    func getBooks() {
        isLoadingVariable.accept(true)
        booksProvider.request(.books, completion: { result in
            self.isLoadingVariable.accept(false)

            if case let .success(response) = result {
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()

                    let json = JSON(filteredResponse.data)

                    if !json.isError {
                        let items = json["data"].arrayValue.compactMap {
                            BookTableViewCellType.normal(cellViewModel: Book(fromJson: $0))
                        }

                        // var items = [BookTCVM]()
//                        for item in json["data"] {
//                            let book = Book(fromJson: item.1)
//                            items.append(book)
//                            //self.bookCells.append(book)
//                        }
                        self.cells.accept(items)
                    }
                } catch {
                    self.alertMessageVariable.onNext(AlertMessage(title: error.localizedDescription, message: ""))
                }
            } else {
                self.alertMessageVariable.onNext(AlertMessage(title: result.error?.errorDescription, message: ""))
            }
        })
    }
}
