//
//  TypingLabel.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/15/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class TypingLabel: UILabel {

    open var delegate: TypingLabelDelegate? = nil
    
    // Public properties
    public var interval: Double = 0.1
    
    // Private properties
    private var isTypingComplete: Bool = true
    public var isTypingStopped: Bool = true
    private var stoppedSubstring: String?
    private var stringAttributes: [NSAttributedStringKey: Any]?
    private var currentDispatchID: Int = 900
    private let dispatchQueue = DispatchQueue(label: "TypingLabelDispatchQueue")
    
    // Label override properties
    override open var text: String! {
        get {
            return super.text
        }
        set {
            if interval < 0 {
                interval = -interval
            }
            currentDispatchID += 1
            isTypingComplete = false
            isTypingStopped = false
            stoppedSubstring = nil
            stringAttributes = nil
            setTextWithAnimation(text: newValue, stringAttributes: stringAttributes, interval: interval, dispatchID: currentDispatchID, initialized: true)
        }
    }
    
    override open var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        set {
            if interval < 0 {
                interval = -interval
            }
            currentDispatchID += 1
            isTypingComplete = false
            isTypingStopped = false
            stoppedSubstring = nil
            stringAttributes = newValue.attributes(at: 0, effectiveRange: nil)
            setTextWithAnimation(text: newValue.string, stringAttributes: stringAttributes, interval: interval, dispatchID: currentDispatchID, initialized: true)
        }
    }
    
    
    // MARK: - Public Methods
    
    public func beginTyping() {
        guard isTypingComplete == false || isTypingStopped == true else {
            return
        }
        
        guard let stoppedSubstring = stoppedSubstring else {
            return
        }
        
        isTypingStopped = false
        setTextWithAnimation(text: stoppedSubstring, stringAttributes: stringAttributes, interval: interval, dispatchID: currentDispatchID, initialized: false)
    }
    
    public func stopTyping() {
        isTypingStopped = true
    }
    
    
    // MARK: - Private Animation Methods
    
    private func setTextWithAnimation(text: String, stringAttributes: Dictionary<NSAttributedStringKey, Any>?, interval: TimeInterval, dispatchID: Int, initialized: Bool) {
        guard text.count > 0 && currentDispatchID == dispatchID else {
            isTypingComplete = true
            isTypingStopped = false
            delegate?.typingLabelDidComplete(self)
            return
        }
        
        guard isTypingStopped == false else {
            stoppedSubstring = text
            return
        }
        
        if initialized == true {
            super.text = ""
        }
        
        let firstCharacterIndex = text.index(text.startIndex, offsetBy: 1)
        
        DispatchQueue.main.async {
            if let stringAttributes = stringAttributes {
                super.attributedText = NSAttributedString(string: super.attributedText!.string + String(text[..<firstCharacterIndex]), attributes: stringAttributes)
            }
            else {
                super.text = super.text! + String(text[..<firstCharacterIndex])
            }
            
            self.dispatchQueue.asyncAfter(deadline: .now() + interval) { [weak self] in
                if self?.isTypingStopped == false {
                    let nextString = String(text[firstCharacterIndex...])
                    self?.setTextWithAnimation(text: nextString, stringAttributes: stringAttributes, interval: interval, dispatchID: dispatchID, initialized: false)
                }
            }
        }
    }

}



// MARK: TypingLabelDelegate

protocol TypingLabelDelegate {
    func typingLabelDidComplete(_ label: TypingLabel)
}
