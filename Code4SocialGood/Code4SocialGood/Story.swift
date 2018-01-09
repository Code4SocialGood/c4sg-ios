//
//  Story.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import ObjectMapper

class Story: Mappable {

    var body: String?
    var id: Int!
    var imageUrl: String?
    var title: String?
    var type: String?
    var userId: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        body        <- map["body"]
        id          <- map["id"]
        imageUrl    <- map["imageUrl"]
        title       <- map["title"]
        type        <- map["type"]
        userId      <- map["userId"]
    }
    
}

/* GET /api/stories
{
    "body": "string",
    "id": 0,
    "imageUrl": "string",
    "title": "string",
    "type": "string",
    "userId": 0
}
*/
