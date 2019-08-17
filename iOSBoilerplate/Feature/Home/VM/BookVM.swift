//
//  HomeTCVM.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//


protocol BookVM {
    var bookVM: Book { get }
    var titleVM: String { get }
    var subTitleVM: String { get }
    var previewVM: String { get }
    var descriptionVM: String { get }
}

extension Book: BookVM {
    var bookVM: Book {
        return self
    }

    var titleVM: String {
        return title
    }

    var subTitleVM: String {
        return subTitle
    }

    var previewVM: String {
        return preview
    }

    var descriptionVM: String {
        return descriptionField
    }
}
