//
//  ProjectsViewController.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/3/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let projectCellIdentifier = "ProjectCellIdentifier"
    
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: projectCellIdentifier)!
        return cell
    }
    
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func getProjects(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if(response.result.isSuccess){
                print("We have data!")
                let projectJSON : JSON = JSON(response.result.value!)
                print(projectJSON)
            }
            else{
                print("There is an error getting data")
            }
        }
    }
}
