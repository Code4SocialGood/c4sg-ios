//
//  OrganizationProtocol.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/9/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Foundation

protocol OrganizationProtocol{
    // MARK: - Organization Rest API calls contract
    func getOrganizations(url:String)
    func getTotalCountries(url:String)
    func getOrganizationsBySearch(url:String, keyWord: String, orgCountries: [String], openOpportunities: Bool, orgStatus: String, orgCategory:[String], pageResults: Int, orgSize: Int)
    func getOrganizationUsersById(url: String, orgID:Int)
    func getOrgById(url: String, orgID: Int)
}
