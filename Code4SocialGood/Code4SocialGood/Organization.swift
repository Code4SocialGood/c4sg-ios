//
//  Organization.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import ObjectMapper

// TODO: Conform Organization to a NSManagedObject through the MappableEntity protocol when we move to Core Data.

class Organization: Mappable {
    
    var address1: String?
    var address2: String?
    var category: String?
    var city: String?
    var contactEmail: String?
    var contactName: String?
    var contactPhone: String?
    var contactTitle: String?
    var country: String?
    var createdTime: String?
    var ein: String?
    var facebook_url: String?
    var id: Int!
    var latitude: Double?
    var linkedin_url: String?
    var logoUrl: String?
    var longitude: Double?
    var name: String?
    var organizationDescription: String? // Mapped from "description"
    var projectUpdatedTime: String?
    var state: String?
    var status: String?
    var twitter_url: String?
    var websiteUrl: String?
    var zip: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        address1                <- map["address1"]
        address2                <- map["address2"]
        category                <- map["category"]
        city                    <- map["city"]
        contactEmail            <- map["contactEmail"]
        contactName             <- map["contactName"]
        contactPhone            <- map["contactPhone"]
        contactTitle            <- map["contactTitle"]
        country                 <- map["country"]
        createdTime             <- map["createdTime"]
        ein                     <- map["ein"]
        facebook_url            <- map["facebook_url"]
        id                      <- map["id"]
        latitude                <- map["latitude"]
        linkedin_url            <- map["linkedin_url"]
        logoUrl                 <- map["logoUrl"]
        longitude               <- map["longitude"]
        name                    <- map["name"]
        organizationDescription <- map["description"]
        projectUpdatedTime      <- map["projectUpdatedTime"]
        state                   <- map["state"]
        status                  <- map["status"]
        twitter_url             <- map["twitter_url"]
        websiteUrl              <- map["websiteUrl"]
        zip                     <- map["zip"]
    }
    
}

/* GET /api/organizations
{
    "address1": "string",
    "address2": "string",
    "category": "string",
    "city": "string",
    "contactEmail": "string",
    "contactName": "string",
    "contactPhone": "string",
    "contactTitle": "string",
    "country": "string",
    "createdTime": "string",
    "description": "string",
    "ein": "string",
    "facebook_url": "string",
    "id": 0,
    "latitude": 0,
    "linkedin_url": "string",
    "logoUrl": "string",
    "longitude": 0,
    "name": "string",
    "projectUpdatedTime": "string",
    "state": "string",
    "status": "string",
    "twitter_url": "string",
    "websiteUrl": "string",
    "zip": "string"
}
*/
