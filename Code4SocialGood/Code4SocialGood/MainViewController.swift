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
    
    @IBOutlet weak var typingLabel: TypingLabel!
    private var typingLabelCurrentIndex: Int = 1
    private var typingLabelStrings: [String] = [ "FUN",
                                                 "A BETTER WORLD",
                                                 "SOCIAL GOOD",
                                                 "INTEREST" ]
    private var typingLabelColors: [UIColor] = [ UIColor(red: 244/255, green: 146/255, blue: 34/255, alpha: 1),
                                                 UIColor(red: 113/255, green: 29/255, blue: 247/255, alpha: 1),
                                                 UIColor(red: 252/255, green: 37/255, blue: 97/255, alpha: 1),
                                                 UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1) ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        if useVideoAsBackground {
            createVideoBackground()
        }
        else {
            createImageBackground()
        }
        backgroundView.alpha = 0.5
        
        typingLabel.interval = 0.12
        typingLabel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // Set text to start
        typingLabel.text = ""
        typingLabel.textColor = typingLabelColors[0]
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
    
    
    // MARK: - TypingLabel Methods
    
    private func getNextWordForTypingLabel() {
        typingLabel.text = typingLabelStrings[self.typingLabelCurrentIndex]
        typingLabel.textColor = typingLabelColors[self.typingLabelCurrentIndex]
        
        if self.typingLabelCurrentIndex >= 3 {
            self.typingLabelCurrentIndex = 0
        }
        else {
            self.typingLabelCurrentIndex += 1
        }
    }
    
    
    // MARK: - TypingLabelDelegate Methods
    
    internal func typingLabelDidComplete(_ label: TypingLabel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getNextWordForTypingLabel()
        }
    }
    
}
