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
    
    /**
     Retrieves an organization from remote server filtered by organization ID.
     
     - Parameter id: The ID of the organization to be searched for.
     - Parameter complete: Returns an Array object containing an array of Organization objects if success, or an Error object if failed.
     */
    func getOrganizationByID(id: Int64, complete: @escaping ([Organization]?, CustomError?) -> ())
    
    /**
     Retrieves the total number of organizations from remote server associated to Code for Social Good.
     
     - Parameter complete: Returns a the number of organizations if success, or an Error object if failed.
     */
    func getOrganizationsCountryCount(complete: @escaping (Int64?, CustomError?) -> ())
    
    /**
     Retrieves all organizations from remote server filtered by user ID.
     
     - Parameter id: The ID of the user to be searched for.
     - Parameter complete: Returns an Array object containing an array of Organization objects if success, or an Error object if failed.
     */
    func getOrganizationsByUserID(id: Int64, complete: @escaping ([Organization]?, CustomError?) -> ())
    
    /**
     Retrieves a list of organizations that were filtered by a search.
     
     - Parameter keyWord: String to search by.
     - Parameter countries: Array of countries.
     - Parameter open: Opportunities open in the organization.
     - Parameter status: Organizations status (A: ACTIVE, C: Closed).
     - Parameter category: Category of the organization to return.
     - Parameter pageNumber: Results page you want to retrieve (0..N).
     - Parameter pageSize: Number of records per page.
     - Parameter complete: Returns an Array object containing an array of Dictionary objects if success, or an Error object if failed.
     */
    func getOrganizationsBySearch(keyWord: String?, countries: [String]?, open: Bool?, status: String?, category: [String]?, pageNumber: Int?, pageSize: Int?, complete: @escaping ([Organization]?, CustomError?) -> ())
    
}
