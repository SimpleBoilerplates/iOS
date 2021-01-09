//
//  Extension+Json.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import SwiftyJSON

func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

extension JSON {
    var isError: Bool {
        return self["error"].boolValue
    }

    var isRefreshedTokenExpired: Bool {
        return self["code"].intValue == 4000
    }

    var message: String {
        return self["message"].stringValue
    }

    var data: [[String: JSON]] {
        return [self["data"].dictionaryValue]
    }

    var errors: [Any] {
        return self["errors"].arrayValue
    }
}
