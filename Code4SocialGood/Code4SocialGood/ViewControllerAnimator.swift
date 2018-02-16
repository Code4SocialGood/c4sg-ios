//
//  ViewControllerAnimator.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/29/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Public properties
    internal var presenting: Bool = true
    internal var initialFrame: CGRect = CGRect.zero
    
    
    // MARK: - Public Animation Methods
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get the container view
        let containerView = transitionContext.containerView
        
        // Set the presenting view controllers
        let fromViewController: UIViewController = transitionContext.viewController(forKey: .from)!
        let toViewController: UIViewController = transitionContext.viewController(forKey: .to)!
        
        // Create the animation and display the new view controller
        let duration = transitionDuration(using: transitionContext)
        
        if presenting {
            
            // Add the subview to the transitioning container view
            containerView.addSubview(toViewController.view)
            
            // Get the to view controller's frame or constraints (To keep this animator generic, we're using frames here)
            //let toViewControllerOldFrame = CGRect(x: initialFrame.origin.x, y: initialFrame.origin.y, width: initialFrame.size.width, height: initialFrame.size.height)
            let toViewControllerOldFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: initialFrame.size.width, height: initialFrame.size.height)
            let toViewControllerNewFrame = toViewController.view.frame
            
            // Get the to new view controller's frame or constraints
            toViewController.view.frame = toViewControllerOldFrame
            toViewController.view.alpha = 0
            toViewController.view.transform = CGAffineTransform(scaleX: toViewControllerOldFrame.width / toViewControllerNewFrame.width,
                                                                y: toViewControllerOldFrame.height / toViewControllerNewFrame.height)
            
            // Add the animation key frames to be animated
            UIView.animateKeyframes(withDuration: duration,
                                    delay: 0,
                                    options: .calculationModeCubic,
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0.5,
                                                           animations: {
                                                            toViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                                                            toViewController.view.alpha = 1
                                                            toViewController.view.frame = toViewControllerNewFrame
                                        })
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        else {
            // Add the subview to the transitioning container view
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            
            // Calculate the new frame size
            let screenBounds = UIScreen.main.bounds
            let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
            let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
            
            UIView.animate(withDuration: duration,
                           animations: {
                            fromViewController.view.frame = finalFrame
            },
                           completion: { _ in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                            if !transitionContext.transitionWasCancelled {
                                // To resolve iOS black screen issue: http://openradar.appspot.com/radar?id=5320103646199808
                                UIApplication.shared.keyWindow!.addSubview(toViewController.view)
                            }
            })
        }
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
}
