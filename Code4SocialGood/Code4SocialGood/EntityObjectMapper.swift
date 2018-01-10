//
//  EntityObjectMapper.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import CoreData
import ObjectMapper

protocol MappableEntity: Mappable {
    init?(_ map: Map, entityName: String?, managedObjectContext: NSManagedObjectContext?)
}

/**
 EntityObjectMapper is used to conform Mappable objects from the library
 ObjectMapper to be used within Core Data.  ObjectMapper does not have
 direct support for Core Data so this is needed to use Core Data as the
 persistent store.
 */
class EntityObjectMapper<N: MappableEntity> {
    
    // MARK: - Mapping Methods
    
    func map(JSONString: String?, entityName: String?, managedObjectContext: NSManagedObjectContext?) -> N? {
        if let JSONString = JSONString {
            return self.map(JSONString: JSONString, entityName: entityName, managedObjectContext: managedObjectContext)
        }
        return nil
    }
    
    func map(JSONString: String, entityName: String?, managedObjectContext: NSManagedObjectContext?) -> N? {
        if let JSON = parseJSONString(JSON: JSONString) as? String {
            return self.map(JSONString: JSON, entityName: entityName, managedObjectContext: managedObjectContext)
        }
        return nil
    }
    
    func map(JSONString: NSString, entityName: String?, managedObjectContext: NSManagedObjectContext?) -> N? {
        return self.map(JSONString: JSONString, entityName: entityName, managedObjectContext: managedObjectContext)
    }
    
    func map(JSON: AnyObject?, entityName: String?, managedObjectContext: NSManagedObjectContext?) -> N? {
        if let JSON = JSON as? [String: AnyObject] {
            return self.map(JSON: JSON as AnyObject, entityName: entityName, managedObjectContext: managedObjectContext)
        }
        return nil
    }
    
    func map(JSONDictionary: [String: AnyObject], entityName: String?, managedObjectContext: NSManagedObjectContext?) -> N? {
        let map = Map(mappingType: MappingType.fromJSON, JSON: JSONDictionary)
        if var object = N(map, entityName: entityName, managedObjectContext: managedObjectContext) {
            object.mapping(map: map)
            return object
        }
        return nil
    }
    
    
    // MARK: - Private Parsing Methods
    
    private func parseJSONDictionary(JSON: String) -> [String: AnyObject]? {
        let parsedJSON: AnyObject? = parseJSONString(JSON: JSON)
        return parseJSONDictionary(JSON: parsedJSON)
    }
    
    private func parseJSONDictionary(JSON: AnyObject?) -> [String: AnyObject]? {
        if let JSONDict = JSON as? [String: AnyObject] {
            return JSONDict
        }
        return nil
    }
    
    private func parseJSONString(JSON: String) -> AnyObject? {
        let data = JSON.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if let data = data {
            let parsedJSON: AnyObject?
            do {
                parsedJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
            }
            catch let error {
                print("Error parsing JSON: ", error)
                parsedJSON = nil
            }
            return parsedJSON
        }
        return nil
    }
    
}
