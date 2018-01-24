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

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate {
    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let projectCellIdentifier = "ProjectCellIdentifier"
    
    // Project properties
    var projects: [Project] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Projects"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .never  // Use this for detailed views
        
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = searchButtonItem
        
        // Setup table view
        tableView?.separatorStyle = .none
        tableView?.estimatedRowHeight = 150.0
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "ProjectTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: projectCellIdentifier)
        tableView?.allowsSelection = false
        
        // Get all projects
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
    }
    
    
    // MARK: - Button Action Methods
    
    @objc func searchButtonClicked() {
        
    }
    
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProjectTableViewCell.dequeue(fromTableView: tableView, withIdentifier: projectCellIdentifier, atIndexPath: indexPath) as ProjectTableViewCell
        
        // Set project for row
        cell.project = self.projects[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: - BaseTableViewCellDelegate Methods
    
    func cellDidFinishSingleTap(_ cell: UITableViewCell) {
        // Present the project view in a new view controller here
    }
    
    func cellDidBeginLongPress(_ cell: UITableViewCell) {
        // Prepare the view for a the project preview (See App Store app for idea)
    }
    
    func cellDidFinishLongPress(_ cell: UITableViewCell) {
        // Display the project preview view for a the project
    }
    
}
