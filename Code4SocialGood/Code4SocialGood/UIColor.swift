//
//  UIColor.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 2/15/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Code for Social Good Specific colors
    
    class func c4sgGreen() -> UIColor {
        return UIColor(red: 0.518, green: 0.769, blue: 0.294, alpha: 1.0)
    }
    
    
    // MARK: - Color Helper Methods
    
    public func isLight() -> Bool {
        guard let components = cgColor.components, components.count > 2 else {
            return false
        }
        
        // Brightness algorithm: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        if brightness > 0.5 {
            return true
        }
        return false
    }
    
}
