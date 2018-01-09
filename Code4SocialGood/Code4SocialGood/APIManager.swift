//
//  APIManager.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

enum Environment {
    case dev
    case prod
}

class APIManager: NSObject {

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
        let organization: String = "/"
        
        // Project
        let project: String = "/"
        
        // Skill
        let skill: String = "/"
        
        // Story
        let story: String = "/"
        
        // User
        let user: String = "/"
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
    
    
    // MARK - Organization Methods
    
    
    // MARK - Project Methods
    
    
    // MARK - Skill Methods
    
    
    // MARK - Story Methods
    
    
    // MARK - User Methods
    
    
}
