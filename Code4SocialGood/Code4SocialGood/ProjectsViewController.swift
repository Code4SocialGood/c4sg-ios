//
//  ProjectsViewController.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/3/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import Alamofire
import ObjectMapper
import SwiftyJSON
import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let projectCellIdentifier = "ProjectCellIdentifier"
    
    var projects: [Project] = [] // TODO: Refactor this eventually to use CoreData and fetch controllers.
    
    let projectURL = "http://dev-api.code4socialgood.org/api/projects/"
    let projectHeroesURL = "http://dev-api.code4socialgood.org/api/projects/heroes"
    let projectJobTitlesURL = "http://dev-api.code4socialgood.org/api/projects/jobTitles"
    let projectOrgURL = "http://dev-api.code4socialgood.org/api/projects/organization"
    let projectSearchURL = "http://dev-api.code4socialgood.org/api/projects/search"
    let projectUserURL = "http://dev-api.code4socialgood.org/api/projects/user"
    
    //These are not implemented yet since ID is an object parameters that we will have to pass to the function.
    //let projectIdURL = "http://dev-api.code4socialgood.org/api/projects/id"
    //let projectApplicantHeroURL = "http://dev-api.code4socialgood.org/api/projects/id/applicantHeroMap"
    //let projectApplicantsURL = "http://dev-api.code4socialgood.org/api/projects/id/applicants"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: projectCellIdentifier)
        
        
        //Testing REST API calls...
        getProjects(url:projectURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: projectCellIdentifier)!

        // Get project for row
        let project = self.projects[indexPath.row]

        // Set cell title
        var cellTitle: String?
        if let id = project.id, let name = project.name {
            cellTitle = "\(id) - \(name)"
        }
        else if let id = project.id {
            cellTitle = "\(id) - (Missing name)"
        }
        cell.textLabel?.text = cellTitle

        return cell
    }
    
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Restful API Methods
    
    func getProjects(url: String) {
        
        let parameters: Parameters? = nil // Use this when we want to pass parameters to the call
        let headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if (response.result.isSuccess) {
                
                // Verify we have results
                if let array = response.result.value as? [Any] {
                    for object in array {
                        // Create the project model and add to temporary store
                        if let project = Mapper<Project>().map(JSON: object as! [String: Any]) {
                            self.projects.append(project)
                        }
                    }
                    
                    // Sort the array we just set
                    self.projects = self.projects.sorted(by: { $0.id < $1.id })
                    
                    // Reload tableView after retrieving data
                    self.tableView?.reloadData()
                }
                else if let _ = response.result.value as? [AnyHashable: Any] {
                    print("This returned a dictionary.  You'll need to handle this differently.")
                }
            }
            else {
                print("There is an error getting data")
            }
        }
    }
}
