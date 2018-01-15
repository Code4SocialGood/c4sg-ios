//
//  UserProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    /**
     Retrieves all users from remote server.
     
     - Parameter complete: Returns an Array object containing an array of User objects if success, or an Error object if failed.
     */
    func getUsers(complete: @escaping ([User]?, CustomError?) -> ())
    
    /**
     Retrieves a user from remote server filtered by user ID.
     
     - Parameter id: The ID of the user to be searched for.
     - Parameter complete: Returns an Array object containing an array of User objects if success, or an Error object if failed.
     */
    func getUserByID(id: Int64, complete: @escaping ([User]?, CustomError?) -> ())
    
    /**
     Retrieves a user from remote server filtered by user email address.
     
     - Parameter email: The email of the user to be searched for.
     - Parameter complete: Returns an Array object containing an array of User objects if success, or an Error object if failed.
     */
    func getUserByEmail(email: String, complete: @escaping ([User]?, CustomError?) -> ())
    
    
    
    // TODO: Complete/Update the following protocols and methods within API Manager
    
    //func getUserByEmail(url:String, emailAddress:String)
    //func getUserJobTitles(url:String)
    //func getUsersByOrganizationID(url:String, orgID: Int)
    //func getUsersBySearch(url:String, keyWord: String, jobTitles: [Int], userSkills: [Int], userStatus: String, userRole: String, userPublicFlag: Bool, sizeOfRecords: Int)
    //func getUserByID(url:String, userID: Int)
}
