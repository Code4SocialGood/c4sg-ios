//
//  APIManager.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Alamofire
import ObjectMapper
import SwiftyJSON
import UIKit

enum Environment {
    case dev
    case prod
    case heroku
}

class APIManager: NSObject, ProjectProtocol, UserProtocol, StoryProtocol, SkillProtocol, OrganizationProtocol {
    
    let dataErrorMessage = "Unable to get data"

    // Environment properties
    var environment: Environment = .dev
    
    // API properties
    struct APIUrls {
        let dev: String = "http://dev-api.code4socialgood.org/"
        let prod: String = "http://api.code4socialgood.org/"
        let heroku: String = "https://c4sg-prod.herokuapp.com/"
    }
    private let apiURL: String
    private let apiToken: String
    
    struct APIEndpoints {
        // Organization
        let organizations: String               = "api/organizations"
        let organizationCountriesTotal: String  = "api/organizations/countries/total"
        let organizationSearch: String          = "api/organizations/search/"
        let organizationByUser: String          = "api/organizations/user/" // api/organizations/user/{id}
        let organizationById: String            = "api/organizations/" // api/organizations/{id}
        
        // Project
        let projects: String = "api/projects"
        // TODO: Include the other project related API requests.
        
        // Skill
        let skills: String = "api/skills"
        // TODO: Include the other skill related API requests.
        
        // Story
        let stories: String = "api/stories"
        // TODO: Include the other story related API requests.
        
        // User
        let users: String = "api/users"
        // TODO: Include the other user/volunteer related API requests.
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
    
    
    // MARK: - Organization Methods
    
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
    
    func getOrgById(url: String, orgID: Int) {
        //TODO: Implement this method after data is passed to model
    }
    
    func getOrganizationUsersById(url: String, orgID: Int) {
    
    }
    
    func getOrganizationsBySearch(url: String, keyWord: String, orgCountries: [String], openOpportunities: Bool, orgStatus: String, orgCategory: [String], pageResults: Int, orgSize: Int) {
        
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
    
    func getHasJoinedSlackChat(url: String, emailAddress: String) {

    }
    
    
    // MARK: - Project Methods
    
    func getProjects(complete: @escaping ([Project]?, Error?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.organizations)"
        print("  --> GET All Projects: \(urlString)")
        
        let parameters: Parameters? = nil // Use this when we want to pass parameters to the call
        let headers: HTTPHeaders = [ "Accept": "application/json" ] // Consider this being a helper method if all calls have the same headers
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if (response.result.isSuccess) {
                
                // Verify we have results
                if let array = response.result.value as? [Any] {
                    var projects: [Project] = []
                    for object in array {
                        // Create the project model and add to temporary store
                        if let project = Mapper<Project>().map(JSON: object as! [String: Any]) {
                            projects.append(project)
                        }
                    }
                    
                    // Sort the array we just set
                    projects = projects.sorted(by: { $0.id < $1.id })
                    
                    complete(projects, nil)
                }
                else if let _ = response.result.value as? [AnyHashable: Any] {
                    print("This returned a dictionary.  You'll need to handle this differently.")
                    // TODO: Create the error object and pass that
                    complete(nil, nil)
                }
            }
            else {
                print("There is an error getting data")
                // TODO: Create the error object and pass that
                complete(nil, nil)
            }
        }
    }
    
    func getProjectApplicantById(url: String, applicantId: Int, userId: Int, appStatus: String) {

    }

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
    
    func getProjectOrganization(url: String, orgID: Int, projectStatus: String) {

    }
    
    func getProjectsBySearch(url: String, keyWord: String, jobTitles: [Int], skills: [Int], projectStatus: String, projectLoc: String, pageResults: Int, sizeOfRecords: Int) {
        
    }
    
    func getProjectsByUserID(url: String, userID: Int, userStatus: String) {

    }
    
    func getProjectbyID(url: String, projectID: Int) {

    }
    
    func getProjectApplicantsByID(url: String, Id: Int) {

    }
    
    
    // MARK: - Skill Methods
    
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
    
    
    // MARK: - Story Methods
    
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
    
    
    // MARK: - User Methods

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
    
    func getUserByEmail(url: String, emailAddress: String) {

    }
    
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
    
    func getUsersByOrganizationID(url: String, orgID: Int) {
 
    }
    
    func getUsersBySearch(url: String, keyWord: String, jobTitles: [Int], userSkills: [Int], userStatus: String, userRole: String, userPublicFlag: Bool, sizeOfRecords: Int) {
 
    }
    
    func getUserByID(url: String, userID: Int) {
 
    }
    
}
