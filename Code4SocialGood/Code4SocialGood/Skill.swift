//
//  Skill.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import ObjectMapper

class Skill: Mappable {

    var id: Int!
    var skillName: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        skillName   <- map["skillName"]
    }
    
}

/* GET /api/skills
{
    "id": 0,
    "skillName": "string"
}
*/
