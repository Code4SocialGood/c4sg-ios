//
//  UserProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol UserProtocol {
    // MARK: - Users Rest API calls contract
    func getUsers(url:String)
    func getUserByEmail(url:String, emailAddress:String)
    func getUserJobTitles(url:String)
    func getUsersByOrganizationID(url:String, orgID: Int)
    func getUsersBySearch(url:String, keyWord: String, jobTitles: [Int], userSkills: [Int], userStatus: String, userRole: String, userPublicFlag: Bool, sizeOfRecords: Int)
    func getUserByID(url:String, userID: Int)
}
