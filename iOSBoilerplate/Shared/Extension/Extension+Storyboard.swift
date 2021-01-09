//
//  UIStoryboard+Storyboards.swift
//  AHStoryboard
//
//  Created by Sadman Samee on 23/10/2016.

//  Copyright © 2016 Sadman Samee. All rights reserved.
//

import UIKit

extension UITableViewCell: XIBIdentifiable {}

extension UICollectionViewCell: XIBIdentifiable {}

protocol XIBIdentifiable {
    static var id: String { get }
    static var nib: UINib { get }
}

extension XIBIdentifiable {
    static var id: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}
