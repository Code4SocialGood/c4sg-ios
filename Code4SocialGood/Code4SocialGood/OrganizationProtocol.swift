//
//  OrganizationProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol OrganizationProtocol {
    
    /**
     Retrieves all organizations from remote server.
     
     - Parameter complete: Returns an Array object containing an array of Organization objects if success, or an Error object if failed.
     */
    func getOrganizations(complete: @escaping ([Organization]?, CustomError?) -> ())
    
    
    
    
    // TODO: Complete/Update the following protocols and methods within API Manager
    
    //func getTotalCountries(url:String)
    //func getOrganizationsBySearch(url:String, keyWord: String, orgCountries: [String], openOpportunities: Bool, orgStatus: String, orgCategory:[String], pageResults: Int, orgSize: Int)
    //func getOrganizationUsersById(url: String, orgID:Int)
    //func getOrgById(url: String, orgID: Int)
}
