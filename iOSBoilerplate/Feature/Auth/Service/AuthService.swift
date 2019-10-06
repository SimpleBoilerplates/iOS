//
//  AuthAPI.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Moya

public enum AuthService {
    case login(String, String)
    case signUp(String, String, String)
}

extension AuthService: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: K.Url.base)!
    }

    public var path: String {
        switch self {
        case .login:
            return "login"
        case .signUp:
            return "signup"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case let .signUp(email, password, name):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password], encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .login, .signUp:
            return ["Content-Type": "application/json"]
        }
    }

    public var authorizationType: AuthorizationType {
        switch self {
        //        case .targetThatNeedsBearerAuth:
        //            return .bearer
        //        case .targetThatNeedsBasicAuth:
        //            return .basic
        case .login, .signUp:
            return .none
        }
    }

    public var validationType: ValidationType {
        switch self {
        case .login, .signUp:
            return .successCodes
        default:
            return .none
        }
    }

    public var sampleData: Data {
        if isRunningTests {
            switch self {
            case .login, .signUp:
                return "".data(using: String.Encoding.utf8)!
            }
        } else {
            return "".data(using: String.Encoding.utf8)!
        }
    }
}
