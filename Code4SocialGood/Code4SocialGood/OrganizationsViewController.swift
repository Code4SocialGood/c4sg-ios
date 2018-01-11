//
//  OrganizationsViewControllerViewController.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/3/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OrganizationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    let organizationCellIdentifier = "OrganizationCellIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we have a custom cell register it here, or you can use the storyboard to design/register the cell
        //tableView.register(OrganizationTableViewCell.self, forCellReuseIdentifier: organizationCellIdentifier)
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: organizationCellIdentifier)!
        return cell
    }
    
    
    // MARK: - UITableViewDelegate Methods
}
