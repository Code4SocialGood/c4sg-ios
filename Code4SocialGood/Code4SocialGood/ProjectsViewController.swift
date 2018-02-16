//
//  ProjectsViewController.swift
//  Code4SocialGood
//
//  Created by iOS Development on 1/3/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate, UIViewControllerTransitioningDelegate {
    
    // Table view properties
    @IBOutlet weak var tableView: UITableView?
    private let projectCellIdentifier = "ProjectCellIdentifier"
    
    // Project properties
    private var projects: [Project] = []
    private var selectedProject: Project?
    
    // Segue & segue animation properties
    private let showProjectDetailsSegue = "ShowProjectDetailsSegue"
    private let viewControllerAnimator = ViewControllerAnimator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem = searchButtonItem
        
        // Setup table view
        tableView?.separatorStyle = .none
        tableView?.estimatedRowHeight = 150.0
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: ProjectTableViewCell.nibName, bundle: .main), forCellReuseIdentifier: projectCellIdentifier)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showProjectDetailsSegue {
            // Pass the project's details to the view controller
            if let projectDetailsViewController = segue.destination as? ProjectDetailsViewController, let project = self.selectedProject {
                projectDetailsViewController.project = project
                projectDetailsViewController.transitioningDelegate = self
                self.selectedProject = nil
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.projects.count > 0 {
            return 34
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addBorders(edges: [.bottom], color: UIColor(white: 0.9, alpha: 1.0), thickness: 1.0)
        
        let label = PaddedLabel.init(insets: 0, 0, 16, 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "\(self.projects.count) Projects Found"
        view.addSubview(label)
        
        // Constraint view dictionaries
        let viewsDict = [
            "label": label
        ]
        
        // Horizontal constraints
        let headerHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        view.addConstraints(headerHorizontalConstraints)
        
        // Vertical constraints
        let headerVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        view.addConstraints(headerVerticalConstraints)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProjectTableViewCell
        self.selectedProject = cell.project
        
        // Set the cell's card frame
        let rectForRow = tableView.rectForRow(at: indexPath)
        let cellFrame = tableView.convert(rectForRow, to: tableView.superview)
        viewControllerAnimator.initialFrame = cellFrame
        
        // Present the project view in a new view controller here
        self.performSegue(withIdentifier: showProjectDetailsSegue, sender: self)
    }
    
    
    // MARK: - BaseTableViewCellDelegate Methods
    
    func cellDidFinishSingleTap(_ cell: UITableViewCell) {
        let projectCell: ProjectTableViewCell = cell as! ProjectTableViewCell
        self.selectedProject = projectCell.project
        
        // Set the cell's card frame
        /* Use the cardFrame as the initial frame if you wish to bring to view up from the cell location
         let cellFrame = cell.roundedView.convert(projectCell.roundedView.frame, to: nil)
         viewControllerAnimator.initialFrame = cellFrame
        */
        
        // Present the project view in a new view controller here
        self.performSegue(withIdentifier: showProjectDetailsSegue, sender: self)
    }
    
    func cellDidBeginLongPress(_ cell: UITableViewCell) {
        // Prepare the view for a the project preview (See App Store app for idea)
    }
    
    func cellDidFinishLongPress(_ cell: UITableViewCell) {
        // Display the project preview view for a the project
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewControllerAnimator.presenting = true
        return viewControllerAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewControllerAnimator.presenting = false
        return viewControllerAnimator
    }
    
}
