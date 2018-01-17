//
//  MainViewController.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/15/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, TypingLabelDelegate {
    
    // Background properties
    @IBOutlet weak var backgroundView: UIView!
    private let useVideoAsBackground = false
    
    // Typing label properties
    @IBOutlet weak var typingLabel: TypingLabel!
    private var typingLabelCurrentIndex: Int = 0
    private var typingLabelStrings: [String] = [ "FUN...",
                                                 "A BETTER WORLD...",
                                                 "SOCIAL GOOD...",
                                                 "INTEREST..." ]
    private var typingLabelColors: [UIColor] = [ UIColor(red: 244/255, green: 146/255, blue: 34/255, alpha: 1),
                                                 UIColor(red: 113/255, green: 29/255, blue: 247/255, alpha: 1),
                                                 UIColor(red: 252/255, green: 37/255, blue: 97/255, alpha: 1),
                                                 UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1) ]
    
    // Button properties
    @IBOutlet weak var findProjectsButton: UIButton!
    @IBOutlet weak var findOrganizationsButton: UIButton!
    @IBOutlet weak var findVolunteersButton: UIButton!
    
    // Segue properties
    private let findProjectsSegue = "ProjectsSegue"
    private let findOrganizationsSegue = "OrganizationsSegue"
    private let findVolunteersSegue = "VolunteersSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        if useVideoAsBackground {
            createVideoBackground()
        }
        else {
            createImageBackground()
        }
        backgroundView.alpha = 0.4
        
        typingLabel.interval = 0.12
        typingLabel.delegate = self
        
        findProjectsButton.backgroundColor = UIColor(red: 242/255, green: 103/255, blue: 59/255, alpha: 1)
        findProjectsButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        findOrganizationsButton.backgroundColor = UIColor(red: 242/255, green: 103/255, blue: 59/255, alpha: 1)
        findOrganizationsButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        findVolunteersButton.backgroundColor = UIColor(red: 242/255, green: 103/255, blue: 59/255, alpha: 1)
        findVolunteersButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set text to start
        typingLabel.text = typingLabelStrings[self.typingLabelCurrentIndex]
        typingLabel.textColor = typingLabelColors[self.typingLabelCurrentIndex]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        typingLabel.stopTyping()
    }
    
    
    // MARK: - Background Methods
    
    private func createVideoBackground() {
        let backgroundVideoView = BackgroundVideoView()
        backgroundVideoView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(backgroundVideoView)
        
        backgroundVideoView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        backgroundVideoView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        backgroundVideoView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        backgroundVideoView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
    }
    
    private func createImageBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "BackgroundChild")!)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        backgroundView.addSubview(backgroundImageView)
        
        backgroundImageView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
    }
    
    
    // MARK: - IBAction Methods
    
    @IBAction func findProjectsButtonClicked(sender: AnyObject?) {
        self.performSegue(withIdentifier: findProjectsSegue, sender: nil)
    }
    
    @IBAction func findOrganizationsButtonClicked(sender: AnyObject?) {
        self.performSegue(withIdentifier: findOrganizationsSegue, sender: nil)
    }
    
    @IBAction func findVolunteersButtonClicked(sender: AnyObject?) {
        self.performSegue(withIdentifier: findVolunteersSegue, sender: nil)
    }
    
    
    // MARK: - TypingLabel Methods
    
    private func getNextWordForTypingLabel() {
        if !typingLabel.isTypingStopped {
            self.typingLabelCurrentIndex += 1
            if self.typingLabelCurrentIndex >= 4 {
                self.typingLabelCurrentIndex = 0
            }
            
            typingLabel.text = typingLabelStrings[self.typingLabelCurrentIndex]
            typingLabel.textColor = typingLabelColors[self.typingLabelCurrentIndex]
        }
    }
    
    
    // MARK: - TypingLabelDelegate Methods
    
    internal func typingLabelDidComplete(_ label: TypingLabel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getNextWordForTypingLabel()
        }
    }
    
}
