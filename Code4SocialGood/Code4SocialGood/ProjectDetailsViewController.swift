//
//  ProjectDetailsViewController.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/25/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    // Container properties
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var containerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerBottomConstraint: NSLayoutConstraint!
    
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
        
        /* Temporarily removing until App Store style animations are fully complete.
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
         */
        
        // For iPad (commented out until more focus is set for iPad design
        /*
        contentContainerView.layer.cornerRadius = 14
        contentContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentContainerView.layer.shadowOpacity = 0.15
        contentContainerView.layer.shadowRadius = 8.0 */
 
        // Create the subview blur effect to feel more like a card
        let blur: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let effectView: UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        effectView.frame = self.view.frame
        self.view.insertSubview(effectView, at: 0)
        
        displayProjectDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - Public Constraint Methods
    
    public func positionContainer(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        containerLeadingConstraint.constant = left
        containerTrailingConstraint.constant = right
        containerTopConstraint.constant = top
        containerBottomConstraint.constant = bottom
        self.view.layoutIfNeeded()
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
