//
//	Book.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Book {
    var createdAt: String!
    var descriptionField: String!
    var id: Int!
    var preview: String!
    var subTitle: String!
    var title: String!
    var updatedAt: String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        createdAt = json["createdAt"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        preview = json["preview"].stringValue
        subTitle = json["subTitle"].stringValue
        title = json["title"].stringValue
        updatedAt = json["updatedAt"].stringValue
    }
}
