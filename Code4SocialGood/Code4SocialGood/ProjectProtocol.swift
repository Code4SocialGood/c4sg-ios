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
    
    
    
    //func getProjectApplicantById(url: String, applicantId: Int, userId: Int, appStatus: String)
    //func getProjectHeroes(url:String)
    //func getProjectsJobTitles(url:String)
    //func getProjectOrganization(url:String, orgID: Int, projectStatus: String)
    //func getProjectsBySearch(url:String, keyWord: String, jobTitles: [Int], skills: [Int], projectStatus: String, projectLoc: String, pageResults: Int, sizeOfRecords: Int)
    //func getProjectsByUserID(url: String, userID: Int, userStatus: String)
    //func getProjectApplicantsByID(url:String, Id: Int)
}
