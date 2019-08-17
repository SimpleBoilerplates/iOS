//
//  AuthCoordinatorOutput.swift
//  EncoreJets
//
//  Created by Pavle Pesic on 4/11/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import Foundation

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
