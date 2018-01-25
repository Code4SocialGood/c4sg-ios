//
//  ProjectDetailsViewController.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/25/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    // View properties
    @IBOutlet private weak var projectImageView: AlignedImageView?
    @IBOutlet private weak var projectNameLabel: UILabel?
    @IBOutlet private weak var projectCategoryLabel: UILabel?
    @IBOutlet private weak var projectLocationLabel: UILabel?
    @IBOutlet private weak var projectPostedLabel: UILabel?
    @IBOutlet private weak var projectDescriptionTextView: UITextView?
    
    private let defaultImageName = "C4SGLogoDark"
    
    // Public project properties
    public var project: Project? {
        didSet {
            self.displayProjectDetails()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Project"
        self.navigationItem.largeTitleDisplayMode = .never
        
        displayProjectDetails()
    }
    
    
    // MARK: - Private UI Methods
    
    private func displayProjectDetails() {
        if let project = project {
            // Set project image
            if let imageUrl = project.imageUrl {
                projectImageView?.loadAsyncImageFrom(url: imageUrl, withPlaceholder: UIImage(named: defaultImageName))
            }
            else {
                projectImageView?.image = UIImage(named: defaultImageName)!
            }
            
            // Set project name
            if let name = project.name {
                projectNameLabel?.text = name
            }
            else if let name = project.id {
                projectNameLabel?.text = "Project \(String(name))"
            }
            else {
                projectNameLabel?.text = "No project name"
            }
            
            // Set project category
            projectCategoryLabel?.text = "No project category"
            
            // Set project location
            if let location = project.city {
                projectLocationLabel?.text = location
            }
            else {
                projectLocationLabel?.text = "No project location"
            }
            
            // Set project posted date
            if let createdTime = project.createdTime {
                projectPostedLabel?.text = createdTime
            }
            else {
                projectPostedLabel?.text = "No project date"
            }
            
            // Set project description
            if let description = project.projectDescription {
                projectDescriptionTextView?.text = description
            }
            else {
                projectDescriptionTextView?.text = "No project description"
            }
        }
    }
    
}
