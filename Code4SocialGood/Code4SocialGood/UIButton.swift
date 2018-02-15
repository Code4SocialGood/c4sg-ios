//
//  UIButton.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 2/15/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func set(image: UIImage?, title: String, titlePosition: UIViewContentMode, spacing: CGFloat, state: UIControlState) {
        imageView?.contentMode = .center
        setImage(image, for: state)
        
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont])
        
        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: titlePosition, withTitleSpacing: spacing, withImageSpacing: 0)
        
        titleLabel?.contentMode = .center
        setTitle(title, for: state)
    }
    
    public func update(titlePosition: UIViewContentMode, titleSpacing: CGFloat, imageSpacing: CGFloat, state: UIControlState) {
        imageView?.contentMode = .center
        
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = self.titleLabel!.text!.size(withAttributes: [NSAttributedStringKey.font: titleFont])
        
        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: titlePosition, withTitleSpacing: titleSpacing, withImageSpacing: imageSpacing)
        
        titleLabel?.contentMode = .center
    }
    
    
    // MARK: - Private Methods
    
    private func arrange(titleSize: CGSize, imageRect: CGRect, atPosition position: UIViewContentMode, withTitleSpacing titleSpacing: CGFloat, withImageSpacing imageSpacing: CGFloat) {
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position) {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + titleSpacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: imageSpacing, left: imageSpacing, bottom: imageSpacing, right: -titleSize.width-imageSpacing)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + titleSpacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: imageSpacing, left: imageSpacing, bottom: imageSpacing, right: -titleSize.width-imageSpacing)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: imageSpacing, left: imageSpacing, bottom: imageSpacing, right: -(titleSize.width * 2 + titleSpacing + imageSpacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSpacing-imageSpacing)
            imageInsets = UIEdgeInsets(top: imageSpacing, left: imageSpacing, bottom: imageSpacing, right: imageSpacing)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        titleEdgeInsets = titleInsets
        imageEdgeInsets = imageInsets
    }
    
}
