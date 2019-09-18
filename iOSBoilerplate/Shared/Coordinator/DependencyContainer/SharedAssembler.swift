//
//  SharedContainer.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 9/18/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import Swinject

extension Assembler{
    static let sharedAssembler: Assembler = {
        let  container =  Container()
        let assembler = Assembler([
                AuthAssembly(),
                HomeAssembly()
            ],container: container
        )
        return assembler
    }()
}
