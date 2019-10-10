//
//  ViewController.swift
//  ExtraaNumber
//
//  Created by sadman samee on 13/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.

import RxCocoa
import RxSwift
import Swinject
import UIKit

protocol HomeVCProtocol: class {
    // var onBack: (() -> Void)? { get set }
    var onSignOut: (() -> Void)? { get set }
    var onBookSelected: ((BookDetailVM) -> Void)? { get set }
}

class HomeVC: BaseViewController, HomeVCProtocol, HomeStoryboardLodable {
    @IBOutlet var tableView: UITableView!

    var viewModel: HomeVM!
    var userService: UserService! 

    private var disposeBag = DisposeBag()

    // MARK: - HomeVCProtocol

    var onSignOut: (() -> Void)?
    var onBookSelected: ((BookDetailVM) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        setUpTableView()
        bindViewModel()
        let nav = navigationController as! CoordinatorNavigationController
        nav.customizeBackButton()
    }

    // MARK: - Overrides

    override func didSelectCustomBackAction() {
        // self.onBack?()
    }

    // MARK: - Action

    @IBAction func actionLogout(_: Any) {
        userService.logout()
        onSignOut?()
    }
}

// MARK: - Private functions

extension HomeVC {
    private func setLoadingHud(visible: Bool) {
        if visible {
            AppHUD.shared.showHUD()
        } else {
            AppHUD.shared.hideHUD()
        }
    }

    private func bindViewModel() {
        viewModel.getBooks()

        viewModel
            .onShowAlert
            .map { [weak self] in
                AppHUD.shared.showErrorMessage($0.message ?? "", title: $0.title ?? "")
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel
            .onShowingLoading
            .map { [weak self] in
                self?.setLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)


        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView
            .rx
            .modelSelected(BookTableViewCellType.self)
            .subscribe(
                onNext: { [weak self] cellType in
                    if case let .normal(vm) = cellType {
                        self?.onBookSelected?(BookDetailVM(bookVM: vm))
                    }
                    if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
                        self?.tableView?.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }
            )
            .disposed(by: disposeBag)

        viewModel.bookCells.bind(to: tableView.rx.items) { tableView, _, element in
            // let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case let .normal(viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTC.id) as? BookTC else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel
                return cell
            }
        }.disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension HomeVC {
    func setUpTableView() {
        // tableView.delegate = self
        // tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BookTC.nib, forCellReuseIdentifier: BookTC.id)
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 120
    }
}
