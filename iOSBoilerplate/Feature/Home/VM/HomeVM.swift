//
//  HomeVM.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeVM: BaseVM {
    var reloadTableView: (() -> Void)?
    var bookCells: [BookTCVM] = [BookTCVM]()

    var alert: Alert? {
        didSet {
            showError?(alert!)
        }
    }

    func getBooks() {
        showLoadingHUD?(true)

        booksProvider.request(.books, completion: { result in
            self.showLoadingHUD?(false)
            if case let .success(response) = result {
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()

                    let json = try JSON(filteredResponse.data)

                    if !json.isError {
                        for item in json["data"] {
                            let book = Book(fromJson: item.1)
                            self.bookCells.append(book)
                        }
                        self.showLoadingHUD?(false)
                        self.reloadTableView?()
                    }

                } catch let error {
                    self.alert = Alert(
                        title: (error.localizedDescription),
                        message: "")
                }
            } else {
                self.alert = Alert(
                    title: (result.error?.errorDescription),
                    message: "")
            }
        })
    }
}
