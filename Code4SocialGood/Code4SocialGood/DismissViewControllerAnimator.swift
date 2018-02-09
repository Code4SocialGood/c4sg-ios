//
//  DismissViewControllerAnimator.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 2/7/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class DismissViewControllerAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Public Animation Methods
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        // Add the subview to the transitioning container view
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        // Calculate the new frame size
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        // Create the animation and display the new view controller
        let duration = transitionDuration(using: transitionContext)
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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
}
