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

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let projectCellIdentifier = "ProjectCellIdentifier"

    var projects: [Project] = [] // TODO: Refactor this eventually to use CoreData and fetch controllers.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Projects"
        
        let closeViewButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(closeView))
        navigationItem.rightBarButtonItem = closeViewButtonItem
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: projectCellIdentifier)
      
        APIManager.shared.getProjects() { (projects, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let projects = projects {
                self.projects = projects
                self.tableView?.reloadData()
            }
        }
        
        /*
        APIManager.shared.getProjectByID(id: 82) { (projects, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let projects = projects {
                self.projects = projects
                self.tableView?.reloadData()
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func closeView() {
        self.dismiss(animated: true)
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
    
}
