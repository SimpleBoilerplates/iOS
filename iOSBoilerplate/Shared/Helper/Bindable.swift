//
//  Bindable.swift
//  Farm
//
//  Created by sadman samee on 5/21/18.
//  Copyright © 2018 sadman samee. All rights reserved.
//


class Bindable<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
