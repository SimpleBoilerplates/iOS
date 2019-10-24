//
//  UIStoryboard+Storyboards.swift
//  AHStoryboard
//
//  Created by Sadman Samee on 23/10/2016.

//  Copyright © 2016 Sadman Samee. All rights reserved.
//

import UIKit

// extension UIStoryboard {
//    /// The uniform place where we state all the storyboard we have in our application
//
//    /// Convenience Initializers
//    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
//        self.init(name: storyboard.rawValue, bundle: bundle)
//    }
//
//    /// Class Functions
//    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
//        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
//    }
//
//    /// View Controller Instantiation from Generics
//    /// Old Way:
//
//    func instantiateVC<T: UIViewController>(_: T.Type) -> T {
//        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
//            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
//        }
//
//        return viewController
//    }
//
//    /// New Way
//    func instantiateViewController<T: UIViewController>() -> T {
//        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
//            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
//        }
//
//        return viewController
//    }
// }
//
// protocol StoryboardIdentifiable {
//    static var storyboardIdentifier: String { get }
// }
//
// extension StoryboardIdentifiable where Self: UIViewController {
//    static var storyboardIdentifier: String {
//        return String(describing: self)
//    }
// }
//
// extension UIViewController: StoryboardIdentifiable {}

// extension UITableViewHeaderFooterView:  XIBIdentifiable  {
//
// }
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
