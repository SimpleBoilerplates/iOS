//
//  BookDetailVC.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/15/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit

protocol BookDetailVCProtocol: class {
    var onBack: (() -> Void)? { get set }
}

class BookDetailVC: BaseViewController, BookDetailVCProtocol {

    var viewModel: BookDetailVM?

    var onBack: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Overrides
    override func didSelectCustomBackAction() {
        self.onBack?()
    }
}
