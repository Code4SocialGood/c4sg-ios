//
//  User.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import ObjectMapper

class User: Mappable {

    var avatarUrl: String?
    var chatUsername: String?
    var country: String?
    var createdTime: String?
    var email: String?
    var facebookUrl: String?
    var firstName: String?
    var githubUrl: String?
    var id: Int!
    var introduction: String?
    var jobTitleId: Int!
    var lastName: String?
    var latitude: Double?
    var linkedinUrl: String?
    var longitude: Double?
    var notifyFlag: String?
    var personalUrl: String?
    var phone: String?
    var publishFlag: String?
    var resumeUrl: String?
    var role: String?
    var state: String?
    var status: String?
    var title: String?
    var twitterUrl: String?
    var updatedTime: String?
    var userName: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        avatarUrl       <- map["avatarUrl"]
        chatUsername    <- map["chatUsername"]
        country         <- map["country"]
        createdTime     <- map["createdTime"]
        email           <- map["email"]
        facebookUrl     <- map["facebookUrl"]
        firstName       <- map["firstName"]
        githubUrl       <- map["githubUrl"]
        id              <- map["id"]
        introduction    <- map["introduction"]
        jobTitleId      <- map["jobTitleId"]
        lastName        <- map["lastName"]
        latitude        <- map["latitude"]
        linkedinUrl     <- map["linkedinUrl"]
        longitude       <- map["longitude"]
        notifyFlag      <- map["notifyFlag"]
        personalUrl     <- map["personalUrl"]
        phone           <- map["phone"]
        publishFlag     <- map["publishFlag"]
        resumeUrl       <- map["resumeUrl"]
        role            <- map["role"]
        state           <- map["state"]
        title           <- map["title"]
        twitterUrl      <- map["twitterUrl"]
        updatedTime     <- map["updatedTime"]
        userName        <- map["userName"]
    }
    
}

/* GET /api/users
{
    "avatarUrl": "string",
    "chatUsername": "string",
    "country": "string",
    "createdTime": "string",
    "email": "string",
    "facebookUrl": "string",
    "firstName": "string",
    "githubUrl": "string",
    "id": 0,
    "introduction": "string",
    "jobTitleId": 0,
    "lastName": "string",
    "latitude": 0,
    "linkedinUrl": "string",
    "longitude": 0,
    "notifyFlag": "string",
    "personalUrl": "string",
    "phone": "string",
    "publishFlag": "string",
    "resumeUrl": "string",
    "role": "string",
    "state": "string",
    "status": "string",
    "title": "string",
    "twitterUrl": "string",
    "updatedTime": "string",
    "userName": "string"
}
*/
