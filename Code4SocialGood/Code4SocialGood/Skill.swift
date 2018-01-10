//
//  Skill.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import CoreData
import ObjectMapper

class Skill: NSManagedObject, MappableEntity {

    var id: Int!
    var skillName: String?
    
    
    required init?(map: Map) {
        super.init(entity: NSEntityDescription(), insertInto: nil)
    }
    
    required init?(_ map: Map, entityName: String?, managedObjectContext: NSManagedObjectContext?) {
        super.init(entity: NSEntityDescription.entity(forEntityName: entityName!, in: managedObjectContext!)!, insertInto: nil)
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
