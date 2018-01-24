//
//  VolunteersViewController.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/8/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class VolunteersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let volunteerCellIdentifier = "VolunteerCellIdentifier"
    
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Volunteers"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = searchButtonItem
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(VolunteerTableViewCell.self, forCellReuseIdentifier: volunteerCellIdentifier)
        
        APIManager.shared.getUsers() { (users, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let users = users {
                self.users = users
                self.tableView?.reloadData()
            }
        }
        
        /*
        APIManager.shared.getUserByID(id: 1472) { (users, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let users = users {
                self.users = users
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: volunteerCellIdentifier)!
        
        // Get user for row
        let user = self.users[indexPath.row]
        
        // Set cell title
        var cellTitle: String?
        if let id = user.id, let userName = user.userName {
            cellTitle = "\(id) - \(userName)"
        }
        else if let id = user.id {
            cellTitle = "\(id) - (Missing userName)"
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
