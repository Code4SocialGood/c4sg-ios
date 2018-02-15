//
//  ProjectDetailsViewController.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/25/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    // Container properties
    var effectView: UIVisualEffectView!
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var containerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerBottomConstraint: NSLayoutConstraint!
    
    // View properties
    var closeButton: RoundButton!
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var scrollViewSubView: UIView?
    @IBOutlet private weak var projectHeaderImageView: UIImageView?
    @IBOutlet private weak var projectHeaderImageViewHeight: NSLayoutConstraint?
    @IBOutlet private weak var projectImageView: AlignedImageView?
    @IBOutlet private weak var projectNameLabel: UILabel?
    @IBOutlet private weak var projectLocationLabel: UILabel?
    @IBOutlet private weak var projectPostedLabel: UILabel?
    @IBOutlet private weak var projectDescriptionTextView: UITextView?
    @IBOutlet private weak var bottomView: UIView?
    @IBOutlet private weak var bottomViewBottomConstraint: NSLayoutConstraint?
    @IBOutlet private weak var applyButton: UIButton?
    @IBOutlet private weak var shareButton: UIButton?
    private let defaultImageName = "C4SGLogoDark"
    private let defaultHeaderImageName = "BackgroundChild"
    
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
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        // Create the subview blur effect to feel more like a card
        let blur: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        effectView = UIVisualEffectView (effect: blur)
        effectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        effectView.frame = self.view.frame
        self.view.insertSubview(effectView, at: 0)
        
        // Setup container view properties
        contentContainerView.backgroundColor = UIColor.clear
        
        // For iPad (commented out until more focus is set for iPad design
        /*
        contentContainerView.layer.cornerRadius = 14
        contentContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentContainerView.layer.shadowOpacity = 0.15
        contentContainerView.layer.shadowRadius = 8.0
        positionContainer(left: 40.0, right: 40.0, top: 40.0, bottom: 40.0)
         */
        
        // Setup close button
        addCloseButton()
        
        // Setup bottom view
        setupBottomView()
        
        // Setup scrollView properties
        scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        scrollView?.delegate = self
        
        // Setup the project header image
        projectHeaderImageViewHeight?.constant = 200.0
        
        // Setup project details
        displayProjectDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate bottom view up
        bottomViewBottomConstraint?.constant = 10.0
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 5.0,
                       options: .curveEaseIn,
                       animations: {
                        self.bottomView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    
    // MARK: - Public Constraint Methods
    
    public func positionContainer(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        containerLeadingConstraint?.constant = left
        containerTrailingConstraint?.constant = right
        containerTopConstraint?.constant = top
        containerBottomConstraint?.constant = bottom
        self.view.layoutIfNeeded()
    }
    
    
    // MARK: - Private UI Methods
    
    private func displayProjectDetails() {
        if let project = project {
            
            // Set organization header image
            if let imageUrl = project.imageUrl {
                projectHeaderImageView?.loadAsyncImageFrom(url: imageUrl, withPlaceholder: UIImage(named: defaultHeaderImageName))
            }
            else {
                projectHeaderImageView?.image = UIImage(named: defaultHeaderImageName)!
            }
            
            // Set project image
            if let imageUrl = project.organizationLogoUrl {
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
            
            // Set project location
            if let city = project.city, let state = project.state {
                var location = ""
                if city != "" {
                    location += city
                }
                if state != "" {
                    if location != "" {
                        location += ", " + state
                    }
                    else {
                        location = state
                    }
                }
                
                if location != "" {
                    projectLocationLabel?.text = location
                }
                else {
                    if let organizationName = project.organizationName, organizationName != "" {
                        projectLocationLabel?.text = organizationName
                    }
                }
            }
            else {
                projectLocationLabel?.text = ""
            }
            
            // Set project posted date
            if let createdTimeString = project.createdTime {
                let inputDateFormatter = DateFormatter()
                inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
                if let createdTimeDate = inputDateFormatter.date(from: createdTimeString) {
                    let outputDateFormatter = DateFormatter()
                    outputDateFormatter.dateFormat = "MMM d, yyyy"
                    projectPostedLabel?.text = outputDateFormatter.string(from: createdTimeDate)
                }
                else {
                    projectPostedLabel?.text = ""
                }
            }
            else {
                projectPostedLabel?.text = ""
            }
            
            // Set project description
            if let description = project.projectDescription {
                projectDescriptionTextView?.text = description
                // Used for testing a very long description
                //projectDescriptionTextView?.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            }
            else {
                projectDescriptionTextView?.text = "No project description"
            }
        }
    }
    
    
    // MARK: - Close Button Methods
    
    private func addCloseButton() {
        let buttonWidth: CGFloat = 28.0
        
        closeButton = RoundButton(type: UIButtonType.custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.cornerRadius = buttonWidth/2
        closeButton.borderColor = UIColor.gray
        closeButton.borderWidth = 0.5
        closeButton.backgroundColor = UIColor.darkGray
        closeButton.setTitle(" X ", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        // Horizontal constraints
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -14.0).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        
        // Vertical constraints
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        
        // Test and change button colors
        changeCloseButtonBackgroundColor(scrollOffset: nil)
    }
    
    private func changeCloseButtonBackgroundColor(scrollOffset: CGFloat?) {
        if let headerImageViewHeight = projectHeaderImageViewHeight, let scrollOffset = scrollOffset {
            if (scrollOffset + closeButton.frame.size.height) > headerImageViewHeight.constant {
                // Button is over the white space
                UIView.animate(withDuration: 0.3, animations: {
                    self.closeButton.backgroundColor = UIColor.darkGray
                    self.closeButton.borderColor = UIColor.lightGray
                })
            }
            else {
                // Button is over the header image
                UIView.animate(withDuration: 0.3, animations: {
                    self.closeButton.backgroundColor = UIColor.lightGray
                    self.closeButton.borderColor = UIColor.gray
                })
            }
        }
        else {
            // Button is over the header image
            closeButton.backgroundColor = UIColor.lightGray
            closeButton.borderColor = UIColor.gray
        }
    }
    
    @objc func closeButtonClicked() {
        UIView.animate(withDuration: 0.15, animations: {
            self.closeButton?.alpha = 0.0
            self.bottomView?.alpha = 0.0
        })
        
        self.effectView.removeFromSuperview()
        self.scrollView?.setContentOffset(.zero, animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Bottom View / Button Methods
    
    private func setupBottomView() {
        bottomView?.backgroundColor = UIColor(white: 0.98, alpha: 0.85)
        bottomView?.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        bottomView?.layer.cornerRadius = 8.0
        bottomView?.layer.masksToBounds = false
        bottomView?.layer.shadowColor = UIColor.darkGray.cgColor
        bottomView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomView?.layer.shadowOpacity = 0.25
        bottomView?.layer.shadowRadius = 8.0
        bottomView?.layer.shadowPath = UIBezierPath(roundedRect: bottomView!.bounds, cornerRadius: 8.0).cgPath
        bottomViewBottomConstraint?.constant = -150.0
        
        applyButton?.tintColor = UIColor.c4sgGreen()
        applyButton?.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        applyButton?.layer.borderWidth = 2.0
        applyButton?.layer.borderColor = UIColor.c4sgGreen().cgColor
        applyButton?.layer.cornerRadius = 8
        
        shareButton?.tintColor = UIColor.c4sgGreen()
        shareButton?.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        shareButton?.setImage(UIImage(named: "ShareIcon"), for: UIControlState.normal)
        shareButton?.update(titlePosition: UIViewContentMode.right, titleSpacing: 0, imageSpacing: 6.0, state: UIControlState.normal)
        shareButton?.layer.borderWidth = 2.0
        shareButton?.layer.borderColor = UIColor.c4sgGreen().cgColor
        shareButton?.layer.cornerRadius = 8
    }
    
    
    // MARK: - UIScrollViewDelegate Methods
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset: CGFloat = scrollView.contentOffset.y
        if scrollOffset < 0 {
            // Scale down the scroll view before a dismiss should be called
            let scale: CGFloat = (1000 + scrollOffset) / 1000
            self.scrollView?.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.scrollView?.showsVerticalScrollIndicator = false
            
            // Set corner radius for scroll view
            let maxRadius: CGFloat = 20.0
            var radius: CGFloat = ((maxRadius / scale) - maxRadius) * 10
            if radius > maxRadius {
                radius = maxRadius
            }
            self.scrollView?.layer.cornerRadius = radius
            self.scrollViewSubView?.layer.cornerRadius = radius
            self.scrollViewSubView?.layer.masksToBounds = true
            
            // Change alpha to other items on content view
            if let button = self.closeButton, button.alpha > CGFloat(0) {
                UIView.animate(withDuration: 0.3, animations: {
                    button.alpha = 0.0
                })
            }
            if let bottomView = self.bottomView, bottomView.alpha > CGFloat(0) {
                UIView.animate(withDuration: 0.3, animations: {
                    bottomView.alpha = 0.0
                })
            }
            self.effectView.alpha = scale
            
            // Test when to close the view
            if scrollOffset < -90 {
                self.closeButton?.removeFromSuperview()
                self.bottomView?.removeFromSuperview()
                self.effectView.removeFromSuperview()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            // Reset scroll view details
            self.scrollView?.showsVerticalScrollIndicator = true
            self.scrollViewSubView?.layer.masksToBounds = false
            self.scrollView?.layer.cornerRadius = 0
            self.scrollViewSubView?.layer.cornerRadius = 0
            
            // Reset details of items on content view
            UIView.animate(withDuration: 0.3, animations: {
                self.closeButton?.alpha = 1.0
                self.bottomView?.alpha = 1.0
                self.effectView.alpha = 1.0
            })
        }
        
        // Do the close button visual logic
        changeCloseButtonBackgroundColor(scrollOffset: scrollOffset)
    }
    
}
