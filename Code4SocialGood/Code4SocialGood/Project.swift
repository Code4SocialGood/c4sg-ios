//
//  Project.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import ObjectMapper

// TODO: Conform Project to a NSManagedObject through the MappableEntity protocol when we move to Core Data.

class Project: Mappable {

    var city: String?
    var country: String?
    var createdTime: String?
    var id: Int!
    var imageUrl: String?
    var jobTitleId: Int!
    var name: String?
    var organizationId: String?
    var organizationLogoUrl: String?
    var organizationName: String?
    var projectDescription: String? // Mapped from "description"
    var remoteFlag: String?
    var state: String?
    var status: String?
    var updatedTime: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        city                <- map["city"]
        country             <- map["country"]
        createdTime         <- map["createdTime"]
        id                  <- map["id"]
        imageUrl            <- map["imageUrl"]
        jobTitleId          <- map["jobTitleId"]
        name                <- map["name"]
        organizationId      <- map["organizationId"]
        organizationLogoUrl <- map["organizationLogoUrl"]
        organizationName    <- map["organizationName"]
        projectDescription  <- map["description"]
        remoteFlag          <- map["remoteFlag"]
        state               <- map["state"]
        status              <- map["status"]
        updatedTime         <- map["updatedTime"]
    }
    
}

/* GET /api/projects
{
    "city": "string",
    "country": "string",
    "createdTime": "string",
    "description": "string",
    "id": 0,
    "imageUrl": "string",
    "jobTitleId": 0,
    "name": "string",
    "organizationId": "string",
    "organizationLogoUrl": "string",
    "organizationName": "string",
    "remoteFlag": "string",
    "state": "string",
    "status": "string",
    "updatedTime": "string"
}
*/
