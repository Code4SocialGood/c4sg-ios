//
//  OrganizationsViewControllerViewController.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/3/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class OrganizationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let organizationCellIdentifier = "OrganizationCellIdentifier"
    
    var organizations: [Organization] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Organizations"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = searchButtonItem
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(OrganizationTableViewCell.self, forCellReuseIdentifier: organizationCellIdentifier)
        
        APIManager.shared.getOrganizations() { (organizations, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let organizations = organizations {
                self.organizations = organizations
                self.tableView?.reloadData()
            }
        }
        
        /*
        APIManager.shared.getOrganizationByID(id: 72) { (organizations, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let organizations = organizations {
                self.organizations = organizations
                self.tableView?.reloadData()
            }
        }*/
    }
    
    
    // MARK: - Button Action Methods
    
    @objc func searchButtonClicked() {
        
    }
    
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: organizationCellIdentifier)!
        
        // Get project for row
        let organization = self.organizations[indexPath.row]
        
        // Set cell title
        var cellTitle: String?
        if let id = organization.id, let name = organization.name {
            cellTitle = "\(id) - \(name)"
        }
        else if let id = organization.id {
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
