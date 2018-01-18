//
//  ProjectProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol ProjectProtocol {
    
    /**
     Retrieves all projects from remote server.
     
     - Parameter complete: Returns an Array object containing an array of Project objects if success, or an Error object if failed.
     */
    func getProjects(complete: @escaping ([Project]?, CustomError?) -> ())
    
    /**
     Retrieves a project from remote server filtered by project ID.
     
     - Parameter id: The ID of the project to be searched for.
     - Parameter complete: Returns an Array object containing an array of Project objects if success, or an Error object if failed.
     */
    func getProjectByID(id: Int64, complete: @escaping ([Project]?, CustomError?) -> ())
    
    /**
     Retrieves a list of projects associated to an organization.
     
     - Parameter id: The ID of the organization to be searched for.
     - Parameter complete: Returns an Array object containing an array of Project objects if success, or an Error object if failed.
     */
    func getProjectsByOrganizationID(id: Int64, complete: @escaping ([Project]?, CustomError?) -> ())
    
    /**
     Retrieves a list of projects associated to an user.
     
     - Parameter id: The ID of the user to be searched for.
     - Parameter complete: Returns an Array object containing an array of Project objects if success, or an Error object if failed.
     */
    func getProjectsByUserID(id: Int64, complete: @escaping ([Project]?, CustomError?) -> ())
    
    /**
     Retrieves a list of applicants associated to a project.
     
     - Parameter id: The ID of the project to be searched for.
     - Parameter complete: Returns an Array object containing an array of User objects if success, or an Error object if failed.
     */
    func getProjectApplicantsByID(id: Int64, complete: @escaping ([User]?, CustomError?) -> ())
    
    /**
     Retrieves heroes sorted by number of badges.
     
     - Parameter complete: Returns an Array object containing an array of User objects if success, or an Error object if failed.
     */
    func getProjectHeroes(complete: @escaping ([User]?, CustomError?) -> ())
    
    /**
     Retrieves a list of job titles.
     
     - Parameter complete: Returns an Array object containing an array of Dictionary objects if success, or an Error object if failed.
     */
    func getProjectsJobTitles(complete: @escaping ([Dictionary<String, Any>]?, CustomError?) -> ())
    
    /**
     Retrieves a list of active projects that were filtered by a search.
     
     - Parameter keyWord: String to search by
     - Parameter jobTitles: Array of job titles
     - Parameter skills: Array of skill IDs
     - Parameter status: Project status (A: ACTIVE, C: Closed).
     - Parameter location: Location of the project.
     - Parameter pageNumber: Results page you want to retrieve (0..N).
     - Parameter pageSize: Number of records per page.
     - Parameter complete: Returns an Array object containing an array of Dictionary objects if success, or an Error object if failed.
     */
    func getProjectsBySearch(keyWord: String?, jobTitles: [Int64]?, skills: [Int64]?, status: String?, location: String?, pageNumber: Int?, pageSize: Int?, complete: @escaping ([Project]?, CustomError?) -> ())
    
}
