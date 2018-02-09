//
//  UIColor.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 2/7/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

public extension UIColor {
    
    func isLight() -> Bool {
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
