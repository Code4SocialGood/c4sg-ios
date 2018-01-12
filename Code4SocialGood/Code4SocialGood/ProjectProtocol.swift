//
//  ProjectProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/10/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol ProjectProtocol {
    //MARK: - GET Methods
    
    // MARK: - Projects Rest API calls contract
    func getProjects(complete: @escaping ([Project]?, Error?) -> ())
    
    //func getProjectApplicantById(url: String, applicantId: Int, userId: Int, appStatus: String)
    func getProjectHeroes(url:String)
    func getProjectsJobTitles(url:String)
    //func getProjectOrganization(url:String, orgID: Int, projectStatus: String)
    //func getProjectsBySearch(url:String, keyWord: String, jobTitles: [Int], skills: [Int], projectStatus: String, projectLoc: String, pageResults: Int, sizeOfRecords: Int)
    //func getProjectsByUserID(url: String, userID: Int, userStatus: String)
    //func getProjectbyID(url:String, projectID: Int)
    //func getProjectApplicantsByID(url:String, Id: Int)
}
