//
//  BooksAPI.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/2/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya

public enum BooksService {
    case books
}

extension BooksService: TargetType, AccessTokenAuthorizable {

    public var baseURL: URL {
        return URL(string: Constant.Url.base)!
    }

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

    public var authorizationType: AuthorizationType? {
        switch self {
        case .books:
            return .bearer
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .books:
            return .successCodes
        }
    }
}

extension BooksService: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        switch self {
        case .books:
            return .returnCacheDataElseLoad
        }
    }
}
