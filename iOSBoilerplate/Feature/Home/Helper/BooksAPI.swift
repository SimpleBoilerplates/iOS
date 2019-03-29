//
//  BooksAPI.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import Moya

let tokenClosure: () -> String = {
    AuthHelper.Auth().token
}

let booksProvider = MoyaProvider<Books>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter), AccessTokenPlugin(tokenClosure: tokenClosure)])

public enum Books {
    case books
}

extension Books: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL { return URL(string: K.Url.base)! }
    public var path: String {
        switch self {
        case .books:
            return "books"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .books:
            return .get
        }
    }

    public var sampleData: Data {
        switch self {
        case .books:
            return "".data(using: String.Encoding.utf8)!
        }
    }

    public var task: Task {
        switch self {
        case .books:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .books:
            return ["Content-Type": "application/json"]
        }
    }

    public var authorizationType: AuthorizationType {
        switch self {
        case .books:
            return .bearer
//                    case .targetThatNeedsBasicAuth:
//                    return .basic
//        case .login:
//            return .none
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .books:
            return .successCodes
        default:
            return .none
        }
    }
}
