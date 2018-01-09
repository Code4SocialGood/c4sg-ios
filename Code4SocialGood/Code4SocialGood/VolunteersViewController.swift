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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(VolunteerTableViewCell.self, forCellReuseIdentifier: volunteerCellIdentifier)
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: volunteerCellIdentifier)!
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
