//
//  PresentViewControllerAnimator.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/29/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class PresentViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Public properties
    internal var initialFrame: CGRect = CGRect.zero
    internal var toViewControllerType: AnyClass?
    internal var fromViewControllerType: AnyClass?
    
    // Private properties
    private let shouldUseConstraints = false // See below comment regarding runtime/compile-time type objects
    
    
    // MARK: - Public Animation Methods
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get the container view
        let containerView = transitionContext.containerView
        
        // Set the presenting view controllers
        //var fromViewController: UIViewController! // Currently not used
        var toViewController: UIViewController!
        if shouldUseConstraints {
            /* Note:  Since you cannot cast to a runtime type object, we must cast to a compile-time
             type object.  This means our dynamic class types must be expected before compiling.
             
             If we cast our objects to be less generic, we'll be able to access the class properties
             such as constraints.  This will allow us to customize the animations base on the view's
             properties.
             */
            // Set to view controller
            if toViewControllerType == ProjectDetailsViewController.self {
                // Note:  Example use of using contraints.  Useful when we're designing for both iPad and iPhone.
                let tempViewController = transitionContext.viewController(forKey: .to) as! ProjectDetailsViewController
                tempViewController.positionContainer(left: 40.0,
                                                     right: 40.0,
                                                     top: 40.0,
                                                     bottom: 40.0)
                toViewController = tempViewController
            }
            else {
                toViewController = transitionContext.viewController(forKey: .to)
            }
            
            // Set from view controller (Not currently used)
            //fromViewController = transitionContext.viewController(forKey: .from)
        }
        else {
            //fromViewController = transitionContext.viewController(forKey: .from)
            toViewController = transitionContext.viewController(forKey: .to)
        }
        
        // Add the subview to the transitioning container view
        containerView.addSubview(toViewController.view)
        
        // Get the to view controller's frame or constraints (To keep this animator generic, we're using frames here)
        let toViewControllerOldFrame = CGRect(x: 0, y: initialFrame.origin.y, width: initialFrame.size.width, height: initialFrame.size.height)
        let toViewControllerNewFrame = toViewController.view.frame
        
        // Get the to new view controller's frame or constraints
        toViewController.view.frame = toViewControllerOldFrame
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransform(scaleX: toViewControllerOldFrame.width / toViewControllerNewFrame.width,
                                                            y: toViewControllerOldFrame.height / toViewControllerNewFrame.height)
        
        // Create the animation and display the new view controller
        let duration = transitionDuration(using: transitionContext)
        
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
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.33
    }
    
}
