//
//  K+SB.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import UIKit

// extension UIStoryboard {
//    enum Storyboard: String {
//        case Home
//        case Auth
//    }
// }

enum Storyboard: String {
    case Home
    case Auth
}

protocol StoryboardLodable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

protocol HomeStoryboardLodable: StoryboardLodable {}

protocol AuthStoryboardLodable: StoryboardLodable {}

extension HomeStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "Home"
    }
}

extension AuthStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return "Auth"
    }
}
