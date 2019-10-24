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

protocol HomeVCProtocol: AnyObject {
    // var onBack: (() -> Void)? { get set }
    var onSignOut: (() -> Void)? { get set }
    var onBookSelected: ((BookDetailVM) -> Void)? { get set }
}

class HomeVC: BaseViewController, HomeVCProtocol, HomeStoryboardLodable {
    @IBOutlet var tableView: UITableView!

    var homeViewModel: HomeViewModel!

    private var disposeBag = DisposeBag()

    var btnLogout: UIBarButtonItem!

    // MARK: - HomeVCProtocol

    var onSignOut: (() -> Void)?
    var onBookSelected: ((BookDetailVM) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUI()
        setUpTableView()
        bindViewModel()
        viewModelTableView()
       
       // let nav = navigationController as! CoordinatorNavigationController
       // nav.customizeBackButton()
    }

    
    private func setUI(){
        title = "Books"

        btnLogout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = btnLogout
    }
    
    // MARK: - Overrides

    override func didSelectCustomBackAction() {
        // self.onBack?()
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
        homeViewModel.getBooks()

        btnLogout.rx.tap.asObservable()
            .bind(to: homeViewModel.logoutTapped)
            .disposed(by: disposeBag)

        homeViewModel
            .onLogout
            .map { [weak self] isLoggedOut in

                guard let self = self else {
                    return
                }
                
                if isLoggedOut {
                    self.onSignOut?()
                }
            }
            .subscribe()
            .disposed(by: disposeBag)

        homeViewModel
            .onShowAlert
            .map {

                AppHUD.shared.showErrorMessage($0.message ?? "", title: $0.title ?? "")
            }
            .subscribe()
            .disposed(by: disposeBag)

        homeViewModel
            .onShowingLoading
            .map { [weak self] in
                guard let self = self else {
                    return
                }
                self.setLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func viewModelTableView() {
        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView
            .rx
            .modelSelected(BookTableViewCellType.self)
            .subscribe(
                onNext: { [weak self] cellType in

                    guard let self = self else {
                        return
                    }

                    if case let .normal(vm) = cellType {
                        self.onBookSelected?(BookDetailVM(bookVM: vm))
                    }
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView?.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }
            )
            .disposed(by: disposeBag)

        homeViewModel.onBookCells.bind(to: tableView.rx.items) { tableView, _, element in
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
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BookTC.nib, forCellReuseIdentifier: BookTC.id)
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 120
    }
}
