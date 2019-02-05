//
//  User.swift
//  ExtraaNumber
//
//  Created by sadman samee on 26/1/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Codable {
    var dateOfBirth: String!
    var descriptionField: String?
    var email: String!
    var fullName: String?
    var id: Int!
    // var fId: Int!
    var location: String?
    var phoneNumber: String?
    var ratingAsHero: Int!
    var ratingAsUser: Int!
    var username: String!
    var profileImage: String!
    var accessToken: String!
    var twitterId: String?
    var facebookId: String?
    var googleId: String?
    var instagramId: String?
    var lat: Double!
    var lng: Double!
    var firebaseToken: String!

    init() {}

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty {
            return
        }
        dateOfBirth = json["date_of_birth"].stringValue
        descriptionField = json["description"].string
        email = json["email"].stringValue
        fullName = json["full_name"].string
        id = json["id"].intValue
        // fId = json["fid"].intValue
        location = json["location"].string
        phoneNumber = json["phone_number"].string
        ratingAsHero = json["rating_as_hero"].intValue
        ratingAsUser = json["rating_as_user"].intValue
        username = json["username"].stringValue
        profileImage = json["profile_photo"].stringValue
        accessToken = json["access_token"].stringValue
        firebaseToken = json["firebase_token"].stringValue
        facebookId = json["facebook_id"].string
        googleId = json["google_id"].string
        twitterId = json["twitter_id"].string
        instagramId = json["instagram_id"].string
        lat = json["lat"].doubleValue
        lng = json["lng"].doubleValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if dateOfBirth != nil {
            dictionary["date_of_birth"] = dateOfBirth
        }
        if descriptionField != nil {
            dictionary["description"] = descriptionField
        }
        if email != nil {
            dictionary["email"] = email
        }
        if fullName != nil {
            dictionary["full_name"] = fullName
        }
        if id != nil {
            dictionary["id"] = id
        }

        if location != nil {
            dictionary["location"] = location
        }
        if phoneNumber != nil {
            dictionary["phone_number"] = phoneNumber
        }
        if ratingAsHero != nil {
            dictionary["rating_as_hero"] = ratingAsHero
        }
        if ratingAsUser != nil {
            dictionary["rating_as_user"] = ratingAsUser
        }
        if username != nil {
            dictionary["username"] = username
        }
        if profileImage != nil {
            dictionary["profile_photo"] = profileImage
        }

        if firebaseToken != nil {
            dictionary["firebase_token"] = firebaseToken
        }

        if facebookId != nil {
            dictionary["facebook_id"] = facebookId
        }

        if googleId != nil {
            dictionary["google_id"] = googleId
        }

        if instagramId != nil {
            dictionary["instagram_id"] = instagramId
        }
        if lat != nil {
            dictionary["lat"] = lat
        }
        if lng != nil {
            dictionary["lng"] = lng
        }

        if twitterId != nil {
            dictionary["twitter_id"] = twitterId
        }

        if instagramId != nil {
            dictionary["instagram_id"] = instagramId
        }

        if accessToken != nil {
            dictionary["access_token"] = accessToken
        }

        return dictionary
    }
}
