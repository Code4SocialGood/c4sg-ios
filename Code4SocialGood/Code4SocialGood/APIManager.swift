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

enum Environment {
    case dev
    case prod
    case heroku
}

class APIManager: NSObject, OrganizationProtocol, ProjectProtocol, SkillProtocol, StoryProtocol, UserProtocol {
    
    // Environment properties
    public private(set) var environment: Environment = .dev
    
    // API properties
    private struct APIUrls {
        let dev: String = "http://dev-api.code4socialgood.org/"
        let prod: String = "http://api.code4socialgood.org/"
        let heroku: String = "https://c4sg-prod.herokuapp.com/"
    }
    private let apiURL: String
    private let apiToken: String
    
    private struct APIEndpoints {
        // Organization
        let organizations: String               = "api/organizations"
        let organizationById: String            = "api/organizations/" // api/organizations/{id}
        let organizationCountriesTotal: String  = "api/organizations/countries/total"
        let organizationSearch: String          = "api/organizations/search/"
        let organizationByUser: String          = "api/organizations/user/" // api/organizations/user/{id}
        
        // Project
        let projects: String            = "api/projects"
        let projectById: String         = "api/projects/" // api/projects/{id}
        let projectsJobTitles: String   = "api/projects/jobTitles"
        let projectHeroes: String       = "api/projects/heroes"
        
        // Skill
        let skills: String = "api/skills"
        
        // Story
        let stories: String = "api/stories"
        
        // User
        let users: String = "api/users"
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
    
    
    // MARK: - Organization Methods
    
    public func getOrganizations(complete: @escaping ([Organization]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.organizations)"
        print("  --> GET All Organizations: \(urlString)")
        
        let parameters: Parameters? = nil // Use this when we want to pass parameters to the call
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
                    // Verify we have results
                    if let array = response.result.value as? [Any] {
                        var organizations: [Organization] = []
                        for object in array {
                            // Create the project model and add to temporary store
                            if let organization = Mapper<Organization>().map(JSON: object as! [String: Any]) {
                                organizations.append(organization)
                            }
                        }
                        
                        // Sort the array we just set
                        organizations = organizations.sorted(by: { $0.id < $1.id })
                        
                        complete(organizations, nil)
                    }
                    else if let _ = response.result.value as? [AnyHashable: Any] {
                        let errorString = "This returned a dictionary.  You'll need to handle this differently."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    public func getOrganizationByID(id: Int64, complete: @escaping ([Organization]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.organizationById)\(id)"
        print("  --> GET Organization By ID: \(urlString)")
        
        let parameters: Parameters? = nil
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
                    // Verify we have results
                    if let dictionary = response.result.value as? [AnyHashable: Any] {
                        // Create the project model and add to temporary store
                        var organizations: [Organization] = []
                        if let organization = Mapper<Organization>().map(JSON: dictionary as! [String: Any]) {
                            organizations.append(organization)
                        }
                        complete(organizations, nil)
                    }
                    else {
                        let errorString = "This did not return a dictionary."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    
    // MARK: - Project Methods
    
    public func getProjects(complete: @escaping ([Project]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.projects)"
        print("  --> GET All Projects: \(urlString)")
        
        let parameters: Parameters? = nil // Use this when we want to pass parameters to the call
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
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
                        let errorString = "This returned a dictionary.  You'll need to handle this differently."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    public func getProjectByID(id: Int64, complete: @escaping ([Project]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.projectById)\(id)"
        print("  --> GET Project By ID: \(urlString)")
        
        let parameters: Parameters? = nil
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
                    // Verify we have results
                    if let dictionary = response.result.value as? [AnyHashable: Any] {
                        // Create the project model and add to temporary store
                        var projects: [Project] = []
                        if let project = Mapper<Project>().map(JSON: dictionary as! [String: Any]) {
                            projects.append(project)
                        }
                        complete(projects, nil)
                    }
                    else {
                        let errorString = "This did not return a dictionary."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    public func getProjectsJobTitles(complete: @escaping ([Dictionary<String, Any>]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.projectsJobTitles)"
        print("  --> GET Projects Job Titles: \(urlString)")
        
        let parameters: Parameters? = nil
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
                    // Verify we have results
                    if let array = response.result.value as? [Any] {
                        // Create the project model and add to temporary store
                        var jobTitles: [[String: Any]] = []
                        for object in array {
                            jobTitles.append(object as! [String: Any])
                        }
                        complete(jobTitles, nil)
                    }
                    else {
                        let errorString = "This did not return a dictionary."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    public func getProjectHeroes(complete: @escaping ([User]?, CustomError?) -> ()) {
        let urlString = "\(apiURL)\(apiEndpoints.projectHeroes)"
        print("  --> GET Project Heroes: \(urlString)")
        
        let parameters: Parameters? = nil
        let headers = getHTTPHeaders()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.isSuccess) {
                    
                    // Test if we get an error response from the server
                    if let error = self.testResponseForError(response.result.value as AnyObject) {
                        complete(nil, error)
                        return
                    }
                    
                    // Verify we have results
                    if let array = response.result.value as? [Any] {
                        // Create the project model and add to temporary store
                        var heroes: [User] = []
                        for object in array {
                            // Create the user model and add to temporary store
                            if let user = Mapper<User>().map(JSON: object as! [String: Any]) {
                                heroes.append(user)
                            }
                        }
                        complete(heroes, nil)
                    }
                    else {
                        let errorString = "This did not return a dictionary."
                        complete(nil, CustomError(code: 0, title: nil, description: errorString))
                    }
                }
                else {
                    let errorString = "There is an error getting data"
                    complete(nil, CustomError(code: 0, title: nil, description: errorString))
                }
        }
    }
    
    
    // MARK: - Skill Methods
    
    
    // MARK: - Story Methods
    
    
    // MARK: - User Methods
    
    
    // MARK: - Private Helper Methods
    
    private func getHTTPHeaders() -> HTTPHeaders {
        return [ "Accept": "application/json" ]
    }
    
    private func testResponseForError(_ response: AnyObject?) -> CustomError? {
        if let errorResponse = response as? [AnyHashable: Any],
            let status = errorResponse["status"] as? Int,
            let error = errorResponse["error"] as? String,
            let message = errorResponse["message"] as? String {
            return CustomError(code: status, title: error, description: message)
        }
        return nil
    }
    
}
