//
//  CoreDataManager.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import CoreData
import Foundation

// TODO: Create the Core Data store when we're ready for persistent storage.

class CoreDataManager: NSObject {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: nil)!
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Code4SocialGood.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        let options = [ NSMigratePersistentStoresAutomaticallyOption: true,
                        NSInferMappingModelAutomaticallyOption: true ]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        }
        catch {
            // Report any error
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "com.Code4SocialGood.Code4SocialGood", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    // MARK: - Initialization Methods
    
    static let shared = CoreDataManager()
    
    private override init() {
        super.init()
    }
    
    
    // MARK: - Core Data Saving Methods
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    // MARK: - Core Data Fetching Methods
    
    public func fetchAllOrganizations() -> [Organization]? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Organization")
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request) as! [Organization]
            if results.count > 0 {
                return results
            }
            return nil
        }
        catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return nil
    }
    
    public func fetchAllProjects() -> [Project]? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Project")
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request) as! [Project]
            if results.count > 0 {
                return results
            }
            return nil
        }
        catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return nil
    }
    
    public func fetchAllUsers() -> [User]? {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request) as! [User]
            if results.count > 0 {
                return results
            }
            return nil
        }
        catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return nil
    }
    
}
