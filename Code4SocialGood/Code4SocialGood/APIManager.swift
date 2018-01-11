//
//  APIManager.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum Environment {
    case dev
    case prod
}

class APIManager: NSObject, ProjectProtocol, UserProtocol, StoryProtocol, SkillProtocol, OrganizationProtocol {
 
    let dataErrorMessage = "Unable to get data"

    // Environment properties
    var environment: Environment = .prod
    
    // API properties
    struct APIUrls {
        let dev: String = "http://dev-api.code4socialgood.org/" // TODO: Do we have a dev instance?
        let prod: String = "http://dev-api.code4socialgood.org/"
    }
    public private(set) var apiURL: String!
    public private(set) var apiToken: String!
    
    struct APIEndpoints {
        
        // Organization
        let organization: String = "http://dev-api.code4socialgood.org/api/projects/organization"
        
        // Project
        let project: String = "http://dev-api.code4socialgood.org/api/projects/"
        
        // Skills
        let skill: String = "http://dev-api.code4socialgood.org/api/skills"
        
        // Story
        let story: String = "http://dev-api.code4socialgood.org/api/story"
        
        // Users
        let user: String = "http://dev-api.code4socialgood.org/api/users"
    }
    private let apiEndpoints = APIEndpoints()
    
    
    static let shared = APIManager()
    
    private override init() {
        if environment == .dev {
            apiURL = APIUrls().dev
            apiToken = ""
        }
        else {
            apiURL = APIUrls().prod
            apiToken = ""
        }
    }
    
    deinit {
        
    }
    
    //Commented out methods that require additional parameters in order to function we will eventually consider moving to a repository pattern for all of the methods for code reuse.
    
    //Only GET methods are implemented.
    
    // MARK - Organization Methods
    
    /*func getOrgById(url: String, orgID: Int) {
    //TODO: Implement this method after data is passed to model
    }*/
    
    /*func getOrganizationUsersById(url: String, orgID: Int) {
    
    }*/
    
    func getOrganizations(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let organizationsJSON : JSON = JSON(response.result.value!)
                print(organizationsJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    func getTotalCountries(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let totalCountriesJSON : JSON = JSON(response.result.value!)
                print(totalCountriesJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    /*func getHasJoinedSlackChat(url: String, emailAddress: String) {

    }*/

    // MARK - Project Methods
    
    func getProjects(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let projectJSON : JSON = JSON(response.result.value!)
                print(projectJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    //func getOrganizationsBySearch(url: String, keyWord: String, orgCountries: [String], openOpportunities: Bool, orgStatus: String, orgCategory: [String], pageResults: Int, orgSize: Int) {
        
    //}
    
    //func getProjectApplicantById(url: String, applicantId: Int, userId: Int, appStatus: String) {

    //}
    
    func getProjectHeroes(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let projectHeroesJSON: JSON = JSON(response.result.value!)
                print(projectHeroesJSON)
            }else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    func getProjectsJobTitles(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let projectJobTitlesJSON: JSON = JSON(response.result.value!)
                print(projectJobTitlesJSON)
            }
            else{
                print ("\(self.dataErrorMessage)")
            }
        }
    }
    
    /*func getProjectOrganization(url: String, orgID: Int, projectStatus: String) {

    }
    
    func getProjectsBySearch(url: String, keyWord: String, jobTitles: [Int], skills: [Int], projectStatus: String, projectLoc: String, pageResults: Int, sizeOfRecords: Int) {
        
    }
    
    func getProjectsByUserID(url: String, userID: Int, userStatus: String) {

    }
    
    func getProjectbyID(url: String, projectID: Int) {

    }
    
    func getProjectApplicantsByID(url: String, Id: Int) {

    }*/
    
    
    // MARK - Skill Methods
    
    func getSkills(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let skillsJSON: JSON = JSON(response.result.value!)
                print(skillsJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    // MARK - Story Methods
    func getStories(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let storiesJSON: JSON = JSON(response.result.value!)
                print(storiesJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    
    // MARK - User Methods

    func getUsers(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let usersJSON: JSON = JSON(response.result.value!)
                print(usersJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    /*func getUserByEmail(url: String, emailAddress: String) {

    }*/
    
    func getUserJobTitles(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                let userJobTitlesJSON: JSON = JSON(response.result.value!)
                print(userJobTitlesJSON)
            }
            else{
                print("\(self.dataErrorMessage)")
            }
        }
    }
    
    /*func getUsersByOrganizationID(url: String, orgID: Int) {
 
    }
    
    func getUsersBySearch(url: String, keyWord: String, jobTitles: [Int], userSkills: [Int], userStatus: String, userRole: String, userPublicFlag: Bool, sizeOfRecords: Int) {
 
    }
    
    func getUserByID(url: String, userID: Int) {
 
    }*/
    
    
}
