//
//  BaseVM.swift
//  Farm
//
//  Created by sadman samee on 5/23/18.
//  Copyright © 2018 sadman samee. All rights reserved.
//

import Foundation

class BaseVM {
    var showError: ((_ alert: Alert) -> Void)?
    var showLoadingHUD: ((Bool) -> Void)?
}
